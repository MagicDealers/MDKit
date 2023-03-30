//
//  KeyedDecodingContainer+Additions.swift
//  MDKit
//
//  Created by Jorge Pardo on 11/01/2023.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
    //MARK: - Decoding.
    
    public func decodeValue<T: Decodable>(ofType type: T.Type, forKeys keys: [KeyedDecodingContainer<K>.Key]) throws -> T {
        
        for key in keys {
            
            if let value = try self.decodeIfPresent(type, forKey: key) {
                return value
            }
        }
        
        throw DecodingError.valueNotFound(type,
                                          DecodingError.Context.init(codingPath: keys, debugDescription: "Multiple keys were tested, none returned a value"))
    }
    
    public func decodeValueIfPresent<T: Decodable>(ofType type: T.Type, forKeys keys: [KeyedDecodingContainer<K>.Key]) throws -> T? {
        
        for key in keys {
            
            if let value = try self.decodeIfPresent(type, forKey: key) {
                return value
            }
        }
        
        return nil
    }
}

