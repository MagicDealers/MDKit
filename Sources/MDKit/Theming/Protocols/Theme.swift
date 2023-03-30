//
//  Theme.swift
//  MDKit
//
//  Created by Jorge Pardo on 30/11/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

protocol Theme {
    
    //MARK: - Properties.
    
    var colors: ThemeColors { get }
    var styles: ThemeStyles { get }
}

