//
//  ThemeColors.swift
//  MDKit
//
//  Created by Jorge Pardo on 30/11/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import UIKit

protocol ThemeColors {
    
    //MARK: - Properties.
    
    var good: UIColor { get }
    var fair: UIColor { get }
    var poor: UIColor { get }
    var bad: UIColor { get }
    var unknown: UIColor { get }
    
    var textPrimary: UIColor { get }
    var textPrimaryContrast: UIColor { get }
    
}
