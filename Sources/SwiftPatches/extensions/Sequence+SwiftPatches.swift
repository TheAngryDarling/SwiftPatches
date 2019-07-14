//
//  Sequence+SwiftPatches.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-06-06.
//

import Foundation

public extension Sequence {
    #if !swift(>=4.1.4)
        /// Returns a Boolean value indicating whether every element of a sequence
        /// satisfies a given predicate.
        ///
        /// The following code uses this method to test whether all the names in an
        /// array have at least five characters:
        ///
        ///     let names = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
        ///     let allHaveAtLeastFive = names.allSatisfy({ $0.count >= 5 })
        ///     // allHaveAtLeastFive == true
        ///
        /// - Parameter predicate: A closure that takes an element of the sequence
        ///   as its argument and returns a Boolean value that indicates whether
        ///   the passed element satisfies a condition.
        /// - Returns: `true` if the sequence contains only elements that satisfy
        ///   `predicate`; otherwise, `false`.
        ///
        /// - Complexity: O(*n*), where *n* is the length of the sequence.
        func allSatisfy(_ predicate: (Self.Element) throws -> Bool) rethrows -> Bool {
            var rtn: Bool = true
            for v in self where rtn {
                rtn = try predicate(v)
            }
            return rtn
        }
    #endif
}

public extension Sequence where Element: Equatable {
    /// Returns a Boolean value indicating whether every element of the sequence equals each other
    ///
    /// This is a helper method and is not part of Swift.
    ///
    /// - Returns: `true` if all elements in the sequence equal; otherwise `false`
    /// - Complexity: O(*n*), where *n* is the length of the sequence.
    func allEquals() -> Bool {
        guard let firstElement: Element = self.first(where: { _ in return true }) else { return true }
        return self.allSatisfy({ return $0 == firstElement })
    }
}

