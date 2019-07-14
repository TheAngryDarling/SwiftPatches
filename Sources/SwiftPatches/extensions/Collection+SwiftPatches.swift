//
//  Collection+SwiftPatches.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-06-02.
//

import Foundation

public extension Collection {
    
    #if !swift(>=4.1.4)
        /// Returns the first element of the sequence that satisfies the given predicate.
        ///
        /// - Parameter predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value indicating whether the element is a match.
        /// - Returns: The first element of the sequence that satisfies predicate, or nil if there is no element that satisfies predicate.
        func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> Self.Index? {
            for (i,v) in self.enumerated() {
                if try predicate(v) {
                    #if !swift(>=4.0.4)
                        return self.index(self.startIndex, offsetBy: IndexDistance(i))
                    #else
                        return (i as! Index)
                    #endif
                }
            }
            return nil
        }
    #endif
}

public extension Collection where Element: Equatable {
    
    #if !swift(>=4.1.4)
        /// Available when Element conforms to Equatable.
        ///
        /// - Parameter element: An element to search for in the collection.
        /// - Returns: The first index where element is found. If element is not found in the collection, returns nil.
        func firstIndex(of element: Element) -> Self.Index? {
            return self.firstIndex { $0 == element }
        }
    #endif
}
