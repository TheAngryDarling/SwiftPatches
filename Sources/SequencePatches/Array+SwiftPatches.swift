//
//  Array+SwiftPatches.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-06-10.
//

import Foundation

public extension Array {
    #if !swift(>=4.1.4)
        /// Removes all the elements that satisfy the given predicate.
        ///
        /// Use this method to remove every element in a collection that meets
        /// particular criteria. This example removes all the odd values from an
        /// array of numbers:
        ///
        ///     var numbers = [5, 6, 7, 8, 9, 10, 11]
        ///     numbers.removeAll(where: { $0 % 2 == 1 })
        ///     // numbers == [6, 8, 10]
        ///
        /// - Parameter predicate: A closure that takes an element of the
        ///   sequence as its argument and returns a Boolean value indicating
        ///   whether the element should be removed from the collection.
        ///
        /// - Complexity: O(*n*), where *n* is the length of the collection.
        mutating func removeAll(where predicate: (Element) throws -> Bool) rethrows {
            var idx: Int = 0
            while idx < self.endIndex {
                if try predicate(self[idx]) { self.remove(at: idx) }
                else { idx += 1 }
            }
        }
    #endif
    
}
