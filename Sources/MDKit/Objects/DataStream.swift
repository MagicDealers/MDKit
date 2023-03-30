//
//  DataStream.swift
//  MDKit
//
//  Created by Thecafremo on 14/02/2023.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

public class DataStream {
    
    //MARK: - Properties.
    
    private(set) var totalBytesWritten: Int = 0
    
    private let asyncBytes: URLSession.AsyncBytes
    private weak var delegate: DataStreamDelegate?
    
    //MARK: - Life Cycle.
    
    init(asyncBytes: URLSession.AsyncBytes, delegate: DataStreamDelegate?) {
        
        self.asyncBytes = asyncBytes
        self.delegate = delegate
    }
}

//MARK: - Public Methods.

extension DataStream {
    
    public func start() {
        
        Task { @MainActor in
            
            do {
                
                for try await _ in asyncBytes {
                    totalBytesWritten = totalBytesWritten + 1
                }
                
                delegate?.dataStream(self, didFinishWithError: nil)
                
            } catch {
                delegate?.dataStream(self, didFinishWithError: error)
            }
        }
    }
    
    public func cancel() {
        
        asyncBytes.task.cancel()
        delegate = nil
    }
}

//MARK: - Definitions.

public protocol DataStreamDelegate: AnyObject {
    func dataStream(_ dataStream: DataStream, didFinishWithError error: Error?)
}

