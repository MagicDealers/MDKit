//
//  URL+Additions.swift
//  MDKit
//
//  Created by Jorge Pardo on 30/01/2023.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

//MARK: - Life Cycle.

extension URL {
    
    public init(host: String, path: String?) throws {
        
        var urlString = host
        
        if urlString.hasPrefix(URL.scheme) == false {
            urlString = URL.scheme + urlString
        }
        
        if urlString.hasSuffix("/") == false {
            urlString.append("/")
        }
        
        guard var url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        if var path = path {
            
            if path.hasPrefix("/") {
                path = String(path.dropFirst())
            }
            
            url = url.appending(path: path)
        }
        
        self = url
    }
}

//MARK: - Definitions.

extension URL {
    fileprivate static let scheme = "https://"
}
