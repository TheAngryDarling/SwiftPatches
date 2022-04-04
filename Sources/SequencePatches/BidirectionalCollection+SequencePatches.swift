//
//  BidirectionalCollection+SequencePatches.swift
//  SequencePatches
//
//  Created by Tyler Anger on 2021-03-24.
//

import Foundation

public extension BidirectionalCollection {
    #if !swift(>=4.1.4)
    /// Returns the index of the last element in the collection that matches the
    /// given predicate.
    ///
    /// You can use the predicate to find an element of a type that doesn't
    /// conform to the `Equatable` protocol or to find an element that matches
    /// particular criteria. This example finds the index of the last name that
    /// begins with the letter *A:*
    ///
    ///     let students = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
    ///     if let i = students.lastIndex(where: { $0.hasPrefix("A") }) {
    ///         print("\(students[i]) starts with 'A'!")
    ///     }
    ///     // Prints "Akosua starts with 'A'!"
    ///
    /// - Parameter predicate: A closure that takes an element as its argument
    ///   and returns a Boolean value that indicates whether the passed element
    ///   represents a match.
    /// - Returns: The index of the last element in the collection that matches
    ///   `predicate`, or `nil` if no elements match.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> Self.Index? {
        for (i,v) in self.reversed().enumerated() {
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
    /// Returns the last element of the sequence that satisfies the given
     /// predicate.
     ///
     /// This example uses the `last(where:)` method to find the last
     /// negative number in an array of integers:
     ///
     ///     let numbers = [3, 7, 4, -2, 9, -6, 10, 1]
     ///     if let lastNegative = numbers.last(where: { $0 < 0 }) {
     ///         print("The last negative number is \(lastNegative).")
     ///     }
     ///     // Prints "The last negative number is -6."
     ///
     /// - Parameter predicate: A closure that takes an element of the sequence as
     ///   its argument and returns a Boolean value indicating whether the
     ///   element is a match.
     /// - Returns: The last element of the sequence that satisfies `predicate`,
     ///   or `nil` if there is no element that satisfies `predicate`.
     ///
     /// - Complexity: O(*n*), where *n* is the length of the collection.
     public func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        for v in self.reversed() {
            if try predicate(v) {
                return v
            }
        }
        return nil
     }
    #endif
}

public extension BidirectionalCollection where Element: Equatable {
    #if !swift(>=4.1.4)
    /// Returns the last index where the specified value appears in the
    /// collection.
    ///
    /// After using `lastIndex(of:)` to find the position of the last instance of
    /// a particular element in a collection, you can use it to access the
    /// element by subscripting. This example shows how you can modify one of
    /// the names in an array of students.
    ///
    ///     var students = ["Ben", "Ivy", "Jordell", "Ben", "Maxime"]
    ///     if let i = students.lastIndex(of: "Ben") {
    ///         students[i] = "Benjamin"
    ///     }
    ///     print(students)
    ///     // Prints "["Ben", "Ivy", "Jordell", "Benjamin", "Max"]"
    ///
    /// - Parameter element: An element to search for in the collection.
    /// - Returns: The last index where `element` is found. If `element` is not
    ///   found in the collection, this method returns `nil`.
    ///
    /// - Complexity: O(*n*), where *n* is the length of the collection.
    func lastIndex(of element: Element) -> Self.Index? {
        return self.lastIndex { return $0 == element }
    }
    #endif
}
