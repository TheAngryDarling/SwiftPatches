//
//  Set+CorePatches.swift
//  CorePatches
//
//  Created by Tyler Anger on 2020-10-31.
//

import Foundation

public extension Set where Element: CaseIterable {
    /// Complete set of all available options in `Element: CaseIterable`
    static var all: Set<Element> {
        var rtn = Set<Element>()
        for val in Element.allCases {
            rtn.insert(val)
        }
        return rtn
    }
}
