//
//  Dictionary+SequencePatches.swift
//  SequencePatches
//
//  Created by Tyler Anger on 2020-10-17.
//

import Foundation


public extension Dictionary {
    #if !swift(>=5.0)
    /// Returns a new dictionary containing only the key-value pairs that have
    /// non-`nil` values as the result of transformation by the given closure.
    ///
    /// Use this method to receive a dictionary with non-optional values when
    /// your transformation produces optional values.
    ///
    /// In this example, note the difference in the result of using `mapValues`
    /// and `compactMapValues` with a transformation that returns an optional
    /// `Int` value.
    ///
    ///     let data = ["a": "1", "b": "three", "c": "///4///"]
    ///
    ///     let m: [String: Int?] = data.mapValues { str in Int(str) }
    ///     // ["a": 1, "b": nil, "c": nil]
    ///
    ///     let c: [String: Int] = data.compactMapValues { str in Int(str) }
    ///     // ["a": 1]
    ///
    /// - Parameter transform: A closure that transforms a value. `transform`
    ///   accepts each value of the dictionary as its parameter and returns an
    ///   optional transformed value of the same or of a different type.
    /// - Returns: A dictionary containing the keys and non-`nil` transformed
    ///   values of this dictionary.
    ///
    /// - Complexity: O(*m* + *n*), where *n* is the length of the original
    ///   dictionary and *m* is the length of the resulting dictionary.
    func compactMapValues<T>(_ transform: (Value) throws -> T?) rethrows -> [Key : T] {
        var rtn = Dictionary<Key, T>()
        for (k,v) in self {
            if let nV = try transform(v) {
                rtn[k] = nV
            }
        }
        return rtn
    }
    #endif
}
