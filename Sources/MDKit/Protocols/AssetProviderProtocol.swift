//
//  AssetProvider.swift
//  BeFiler
//
//  Created by Jorge Pardo on 03/10/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import UIKit

public protocol AssetProviderProtocol {
    
    func imageResource(named name: String) -> UIImage?
    func localizedString(forKey key: String) -> String
}
