//
//  Scheduler.swift
//  Platform
//
//  Created by Łukasz Niedźwiedź on 25/07/2018.
//  Copyright © 2018 Niedzwiedz. All rights reserved.
//

import Foundation

public final class Scheduler {
    public let main: SchedulerType = MainScheduler.instance
    public let background: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .background)
}
