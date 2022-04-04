//
//  Sequence+SwiftPatches.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-06-06.
//

import Foundation

public extension Sequence {
    
    #if !swift(>=4.0.4)
        /// Returns an array containing the non-`nil` results of calling the given
        /// transformation with each element of this sequence.
        ///
        /// Use this method to receive an array of nonoptional values when your
        /// transformation produces an optional value.
        ///
        /// In this example, note the difference in the result of using `map` and
        /// `compactMap` with a transformation that returns an optional `Int` value.
        ///
        ///     let possibleNumbers = ["1", "2", "three", "///4///", "5"]
        ///
        ///     let mapped: [Int?] = possibleNumbers.map { str in Int(str) }
        ///     // [1, 2, nil, nil, 5]
        ///
        ///     let compactMapped: [Int] = possibleNumbers.compactMap { str in Int(str) }
        ///     // [1, 2, 5]
        ///
        /// - Parameter transform: A closure that accepts an element of this
        ///   sequence as its argument and returns an optional value.
        /// - Returns: An array of the non-`nil` results of calling `transform`
        ///   with each element of the sequence.
        ///
        /// - Complexity: O(*m* + *n*), where *n* is the length of this sequence
        ///   and *m* is the length of the result.
        func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
            var rtn: [ElementOfResult] = []
            for element in self {
                if let nE = try transform(element) {
                    rtn.append(nE)
                }
            }
            return rtn
        }
    
        /// Returns a Boolean value indicating whether the sequence contains an
        /// element that satisfies the given predicate.
        ///
        /// You can use the predicate to check for an element of a type that
        /// doesn't conform to the `Equatable` protocol, such as the
        /// `HTTPResponse` enumeration in this example.
        ///
        ///     enum HTTPResponse {
        ///         case ok
        ///         case error(Int)
        ///     }
        ///
        ///     let lastThreeResponses: [HTTPResponse] = [.ok, .ok, .error(404)]
        ///     let hadError = lastThreeResponses.contains { element in
        ///         if case .error = element {
        ///             return true
        ///         } else {
        ///             return false
        ///         }
        ///     }
        ///     // 'hadError' == true
        ///
        /// Alternatively, a predicate can be satisfied by a range of `Equatable`
        /// elements or a general condition. This example shows how you can check an
        /// array for an expense greater than $100.
        ///
        ///     let expenses = [21.37, 55.21, 9.32, 10.18, 388.77, 11.41]
        ///     let hasBigPurchase = expenses.contains { $0 > 100 }
        ///     // 'hasBigPurchase' == true
        ///
        /// - Parameter predicate: A closure that takes an element of the sequence
        ///   as its argument and returns a Boolean value that indicates whether
        ///   the passed element represents a match.
        /// - Returns: `true` if the sequence contains an element that satisfies
        ///   `predicate`; otherwise, `false`.
        ///
        /// - Complexity: O(*n*), where *n* is the length of the sequence.
        func contains(where predicate: (Element) throws -> Bool) rethrows -> Bool {
            for element in self {
                if try predicate(element) { return true }
            }
            return false
        }
    #endif
    
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

