//
//  TextSource.swift
//  MDKit
//
//  Created by Jorge Pardo on 28/11/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

public enum TextSource: Equatable {
    
    case literal(String)
    case localized(key: String, parameters: [String]?)
}

//MARK: - Helper Methods.

extension TextSource {
    
    public static func localized(key: String) -> TextSource {
        return .localized(key: key,
                          parameters: nil)
    }
    
    public static func localized(key: String, parameter: String) -> TextSource {
        return .localized(key: key,
                          parameters: [parameter])
    }
}
