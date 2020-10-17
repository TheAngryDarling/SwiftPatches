//
//  BinaryInteger+NumericPatches.swift
//  NumericPatches
//
//  Created by Tyler Anger on 2020-10-17.
//
// Directly imported from https://github.com/apple/swift/blob/main/stdlib/public/core/Integers.swift
import Foundation

public extension BinaryInteger {
    #if !swift(>=5.0)
    /// Returns `true` if this value is a multiple of the given value, and `false`
    /// otherwise.
    ///
    /// For two integers *a* and *b*, *a* is a multiple of *b* if there exists a
    /// third integer *q* such that _a = q*b_. For example, *6* is a multiple of
    /// *3* because _6 = 2*3_. Zero is a multiple of everything because _0 = 0*x_
    /// for any integer *x*.
    ///
    /// Two edge cases are worth particular attention:
    /// - `x.isMultiple(of: 0)` is `true` if `x` is zero and `false` otherwise.
    /// - `T.min.isMultiple(of: -1)` is `true` for signed integer `T`, even
    ///   though the quotient `T.min / -1` isn't representable in type `T`.
    ///
    /// - Parameter other: The value to test.
    func isMultiple(of other: Self) -> Bool {
        // Nothing but zero is a multiple of zero.
        if other == 0 { return self == 0 }
        #if !swift(>=4.1)
            // Special case to avoid overflow on .min / -1 for signed types.
             if Self.isSigned && other == -1 { return true }
             // Having handled those special cases, this is safe.
             return self % other == 0
        #else
            // Do the test in terms of magnitude, which guarantees there are no other
            // edge cases. If we write this as `self % other` instead, it could trap
            // for types that are not symmetric around zero.
            return self.magnitude % other.magnitude == 0
        #endif
    }
    #endif
}
