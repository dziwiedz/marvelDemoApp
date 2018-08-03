//
//  ViewController.swift
//  DemoApp
//
//  Created by Łukasz Niedźwiedź on 20/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import SnapKit
import RxCocoa
import RxSwift
import Domain

final class MainViewController: UIViewController, ErrorPresenting {
    
    //    MARK: - Subviews
    
    let segmentedController = UISegmentedControl(items: [Strings.all, Strings.favorites])
    let searchController = UISearchController(searchResultsController: nil)
    let tableView: UITableView = UITableView()
    var rightBarButton: UIBarButtonItem? {
        return self.navigationItem.rightBarButtonItem
    }
    lazy var spinner: Spinner = {
        let frame = CGRect(origin: .zero, size: LayoutConstants.spinnerViewSize)
        let spinner = Spinner(frame: frame)
        view.addSubview(spinner)
        spinner.center = view.center
        spinner.text = Strings.loading
        spinner.isHidden = false
        return spinner
    }()
    
    //    MARK: - Constants and variables
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let headerHeight: CGFloat = 90
    
    //    MARK: - Dependencies
    
    var viewModel: MainViewModeling!
    
    //    MARK: - UIViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.gameOfThronesArticles
        configureTableView()
        configureNavigationBar()
        configureSearchController()
        configureScopeButtons()
        configureHeaderView()
        configureRxStreams()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //    MARK: - Private methods
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseIdentifier)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.demoRed
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = UIColor.demoWhite
    }
    
    private func configureNavigationBar() {
        let reloadItem = UIBarButtonItem(image: UIImage(named: "refresh_black"), style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = reloadItem
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    private func configureSearchController() {
        definesPresentationContext = true
        let searchBar = searchController.searchBar
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = UIColor.demoWhite
        searchBar.tintColor = UIColor.demoRed
        searchBar.placeholder = Strings.searchArticle
        searchBar.setValue(Strings.cancel, forKey:"_cancelButtonText")
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
    }
    
    private func configureScopeButtons() {
        segmentedController.tintColor = UIColor.demoRed
        segmentedController.backgroundColor = UIColor.demoWhite
        segmentedController.selectedSegmentIndex = FilterScope.all.rawValue
    }
    
    
    private func configureHeaderView() {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: headerHeight)
        let headerView = UIView(frame: frame)
        headerView.addSubview(searchController.searchBar)
        headerView.addSubview(segmentedController)
        segmentedController.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(LayoutConstants.doubledOffset).priority(.high)
            make.top.equalTo(searchController.searchBar.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(4)
        }
        headerView.backgroundColor = UIColor.demoWhite
        tableView.tableHeaderView = headerView
    }
    
    private func configureRxStreams() {
        subcribeToViewModelOuput()
        bindToViewModel()
    }
    
    private func subcribeToViewModelOuput() {
        viewModel
            .errors
            .drive(onNext: {[unowned self] in
                self.presentErrorAlert(message: $0.localizedDescription, title: Strings.errorTitle)
            }).disposed(by: disposeBag)
        
        viewModel
            .isLoading
            .drive(onNext: { [unowned self] in
                self.updateState(whenIsLoading: $0)
            }).disposed(by: disposeBag)
        
        viewModel.filteredArticles
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: ArticleCell.reuseIdentifier, cellType: ArticleCell.self)) {[unowned self] _, article, cell in
                cell.configureCell(withArticle: article,delegate: self)
                self.viewModel.bindFavoritesButtonTap(cell.favoriteButton.rx.tap.asDriver())
            }.disposed(by: disposeBag)
    }
    
    private func bindToViewModel() {
        let searchedText = searchController.searchBar
            .rx
            .text
            .orEmpty
            .asDriver()
            .debounce(0.3)
            .distinctUntilChanged()
        let cancelAction = searchController.searchBar.rx
            .cancelButtonClicked
            .asDriver()
            .map{ "" }
        viewModel.bindSearchedText(Driver.merge(searchedText,cancelAction))
        
        let scope = segmentedController.rx
            .selectedSegmentIndex
            .asDriver()
            .map{ FilterScope(rawValue: $0)!}
        viewModel.bindFilteringScope(scope)
        
        viewModel.bindItemSelection(tableView.rx.itemSelected.asDriver())
        let initialLoadEvent = Driver.just(())
        guard let realodButton = navigationItem.rightBarButtonItem
            else {
                viewModel.bindReloading(initialLoadEvent)
                return
        }
        let tapObservable = realodButton.rx.tap.asDriver()
        viewModel.bindReloading(Driver.merge(tapObservable,initialLoadEvent))
        
    }
    
    private func updateState(whenIsLoading loading: Bool) {
        rightBarButton?.isEnabled = !loading
        if loading {
            spinner.startAnimating()
        } else {
            spinner.stopAnimating()
            tableView.reloadData()
        }
    }
}

extension MainViewController: ArticleCellDelegate {
    func articleCell(_ cell: ArticleCell, didTriggerExpandArticle article: ArticleDTO?) {
        guard let indexPath = tableView.indexPath(for: cell),
            let article = article else { return }
        article.isExpanded = !article.isExpanded
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    func articleCell(_ cell: ArticleCell, didTriggerAddToFavoriteArticle article: ArticleDTO?) {
        guard let indexPath = tableView.indexPath(for: cell),
            let article = article else { return }
        article.isFavorite = !article.isFavorite
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

