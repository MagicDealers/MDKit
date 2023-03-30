//
//  NetworkAccessibilitySubscriber.swift
//  MDKit
//
//  Created by Thecafremo on 25/02/2023.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

public protocol NetworkAccessibilitySubscriber: AnyObject {
    
    //MARK: - Methods.
    
    func networkAccessibilityMonitor(_ monitor: NetworkAccessibilityMonitor, didDetectChangeToInterface interface: NetworkInterface)
}

//MARK: - Definitions.

public enum NetworkInterface {
    case cellular
    case loopback
    case wifi
    case wiredEthernet
    case other
}
