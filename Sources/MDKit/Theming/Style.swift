//
//  Style.swift
//  MDKit
//
//  Created by Jorge Pardo on 30/11/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

struct Style<V> {
    
    //MARK: - Definitions.
    
    typealias StylingClosure = (V, Theme) -> Void
    
    //MARK: - Properties.
    
    private let stylingClosure: StylingClosure
    
    //MARK: - Life Cycle.
    
    init(stylingClosure: @escaping StylingClosure) {
        self.stylingClosure = stylingClosure
    }
}

//MARK: - Public Methods.

extension Style {
    
    func apply(on view: V, with theme: Theme) {
        stylingClosure(view, theme)
    }
}
