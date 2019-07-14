//
//  Bool+SwiftPatches.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-06-06.
//

import Foundation

#if !swift(>=4.1.4)
public extension Bool {
    /// Toggles the Boolean variable’s value.
    mutating func toggle() {
        self = !self
    }
}
#endif
