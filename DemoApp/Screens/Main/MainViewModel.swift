//
//  MainViewModel.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 21/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import RxSwift
import RxCocoa
import Domain

protocol MainViewModeling {
    func bindReloading(_ driver: Driver<Void>)
    func bindFilteringScope(_ driver: Driver<FilterScope>)
    func bindSearchedText(_ driver: Driver<String>)
    func bindFavoritesButtonTap(_ driver: Driver<Void>)
    func bindItemSelection(_ driver: Driver<IndexPath>)
    
    var isLoading: Driver<Bool> { get }
    var errors: Driver<Error> { get }
    var filteredArticles: Driver<[ArticleDTO]> { get }
}

final class MainViewModel:NSObject, MainViewModeling {
    
    
    //    MARK: - Dependencies
    
    private let articleProvider: ArticlesUseCase
    private let navigator: MainNavigating
    private let disposeBag: DisposeBag = DisposeBag()
    
    //    MARK: - Private variables
    
    private var loadingSubject: BehaviorRelay<Bool>  = BehaviorRelay<Bool>(value: false)
    private var errorSubject: PublishSubject<Error> = PublishSubject<Error>()
    private var articleSubject: BehaviorRelay<[ArticleDTO]> = BehaviorRelay<[ArticleDTO]>(value: [])
    private var filteredKeywordSubject: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    private var filteredScopeSubject: BehaviorRelay<FilterScope> = BehaviorRelay<FilterScope>(value: .all)
    private var favoriteTapsSubject: BehaviorRelay<Void> = BehaviorRelay<Void>(value: ())
    
    //    MARK: - Public variables
    
    var isLoading: Driver<Bool> {
        return loadingSubject.asDriver()
    }
    
    var errors: Driver<Error> {
        return errorSubject.asDriver(onErrorJustReturn: UnknownError())
    }
    
    lazy var filteredArticles: Driver<[ArticleDTO]> = Driver
        .combineLatest(articleSubject.asDriver(),
                       filteredKeywordSubject.asDriver(),
                       filteredScopeSubject.asDriver(),
                       favoriteTapsSubject.asDriver())
        { (art, key, scope, _ )  in
            return art
                .filter{ key.isEmpty || "\($0.title.lowercased()) \($0.abstract.lowercased())".contains(key.lowercased()) }
                .filter{ scope == .all ? true : $0.isFavorite }
    }
    
    //    MARK: - Public methods
    
    func bindReloading(_ driver: Driver<Void>) {
        driver
            .do(onNext: { [weak self] in
                self?.loadingSubject.accept(true)
            })
            .asObservable()
            .flatMap{ [unowned self] _ in self.fetchArticles() }
            .do(onNext: { [weak self] articles in
                self?.loadingSubject.accept(false)
            }).bind(to: articleSubject)
            .disposed(by: disposeBag)
    }
    
    func bindFilteringScope(_ driver: Driver<FilterScope>) {
        driver.drive(filteredScopeSubject).disposed(by: disposeBag)
    }
    
    func bindSearchedText(_ driver: Driver<String>) {
        driver.drive(filteredKeywordSubject).disposed(by: disposeBag)
    }
    
    func bindFavoritesButtonTap(_ driver: Driver<Void>) {
        driver.drive(favoriteTapsSubject).disposed(by: disposeBag)
    }
    
    func bindItemSelection(_ driver: Driver<IndexPath>) {
        driver
            .withLatestFrom(filteredArticles) { $1[$0.row] }
            .drive(onNext: { [unowned self] in self.navigator.toDetail(of: $0) })
            .disposed(by: disposeBag)
    }
    
    //    MARK: - Initializers
    
    init(articleProvider: ArticlesUseCase, navigator: MainNavigating) {
        self.articleProvider = articleProvider
        self.navigator = navigator
        super.init()
    }
    
    //    MARK: Private methods
    
    private func fetchArticles() -> Observable<[ArticleDTO]> {
        return articleProvider
            .getArticles()
            .catchError { [weak self] in
                self?.errorSubject.onNext($0)
                return Observable.just([])
        }
    }
}
