//
//  CaseIterable+Additions.swift
//  MDKit
//
//  Created by Jorge Pardo on 08/12/2022.
//  Copyright © 2023 Magic Dealers. All rights reserved.
//

import Foundation

extension CaseIterable where Self: Equatable {
    
    func previous() -> Self {

        let allCases = Self.allCases
        let index = allCases.firstIndex(of: self)!
        let previousIndex = allCases.index(index, offsetBy: -1)

        if previousIndex < allCases.startIndex {
            return self
        }
        
        return allCases[previousIndex]
    }
    
    func next() -> Self {
        
        let allCases = Self.allCases
        let index = allCases.firstIndex(of: self)!
        let nextIndex = allCases.index(after:index)

        if nextIndex == allCases.endIndex {
            return self
        }
        
        return allCases[nextIndex]
    }
}
