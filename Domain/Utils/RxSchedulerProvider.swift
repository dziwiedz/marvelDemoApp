//
//  Scheduler.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//
import Foundation
import RxSwift

public final class RxUtils {
    
    public let shared: RxUtils = RxUtils()
    private init() { }
    
    public var main: SchedulerType  =  MainScheduler.instance 
    public var background: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
}
