//
//  String+Additions.swift
//  MDKit
//
//  Created by Jorge Pardo on 03/10/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

extension String {
    
    static func from(_ textSource: TextSource?, assetProvider: AssetProviderProtocol) -> String? {
        
        guard let textSource = textSource else {
            return nil
        }

        switch textSource {
        case .literal(let text):
            return text
            
        case .localized(let key, let parameters):
            
            if let parameters = parameters {
                return String(format: assetProvider.localizedString(forKey: key),
                              arguments: parameters)
            }
            
            return assetProvider.localizedString(forKey: key)
        }
    }
}
