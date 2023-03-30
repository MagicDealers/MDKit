//
//  NetworkAccessibilityMonitorProtocol.swift
//  MDKit
//
//  Created by Thecafremo on 25/02/2023.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

public protocol NetworkAccessibilityMonitorProtocol {
    
    //MARK: - Methods.
    
    func start()
    
    func subscribe(_ subscriber: NetworkAccessibilitySubscriber)
    func removeSubscriber(_ subscriber: NetworkAccessibilitySubscriber)
}
