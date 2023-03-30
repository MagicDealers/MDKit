//
//  NetworkAccessibilityManager.swift
//  MDKit
//
//  Created by Thecafremo on 24/02/2023.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation
import Network

public final class NetworkAccessibilityMonitor {
    
    //MARK: - Properties.
    
    private let monitor = NWPathMonitor()
    private var subscribers = [NetworkAccessibilitySubscriber]()
}

//MARK: - NetworkAccessibilityMonitorProtocol.

extension NetworkAccessibilityMonitor: NetworkAccessibilityMonitorProtocol {
    
    public func start() {
        
        monitor.pathUpdateHandler = { [weak self] (path: NWPath) in
            
            guard let self = self else { return }
            
            let interface = path.usedInterface
            self.subscribers.forEach { $0.networkAccessibilityMonitor(self, didDetectChangeToInterface: interface) }
        }
        
        monitor.start(queue: .main)
    }
    
    public func subscribe(_ subscriber: NetworkAccessibilitySubscriber) {
        subscribers.append(subscriber)
    }
    
    public func removeSubscriber(_ subscriber: NetworkAccessibilitySubscriber) {
        
        guard let index = subscribers.firstIndex(where: { $0 === subscriber }) else {
            return
        }
        
        subscribers.remove(at: index)
    }
}

//MARK: - Helper Extensions.

extension NWPath {
    
    fileprivate var usedInterface: NetworkInterface {
       
        if self.usesInterfaceType(.cellular) {
            return .cellular
            
        } else if self.usesInterfaceType(.wifi) {
            return .wifi
            
        } else if self.usesInterfaceType(.wiredEthernet) {
            return .wiredEthernet
            
        } else if self.usesInterfaceType(.loopback) {
            return .loopback
        }
        
        return .other
    }
}
