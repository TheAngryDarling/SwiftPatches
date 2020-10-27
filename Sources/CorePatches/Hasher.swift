//
//  Hasher.swift
//  CorePatches
//
//  Created by Tyler Anger on 2020-10-27.
//

import Foundation

#if !swift(>=4.2)
/// The universal hash function used by `Set` and `Dictionary`.
///
/// `Hasher` can be used to map an arbitrary sequence of bytes to an integer
/// hash value. You can feed data to the hasher using a series of calls to
/// mutating `combine` methods. When you've finished feeding the hasher, the
/// hash value can be retrieved by calling `finalize()`:
///
///     var hasher = Hasher()
///     hasher.combine(23)
///     hasher.combine("Hello")
///     let hashValue = hasher.finalize()
///
/// Within the execution of a Swift program, `Hasher` guarantees that finalizing
/// it will always produce the same hash value as long as it is fed the exact
/// same sequence of bytes. However, the underlying hash algorithm is designed
/// to exhibit avalanche effects: slight changes to the seed or the input byte
/// sequence will typically produce drastic changes in the generated hash value.
///
/// - Note: Do not save or otherwise reuse hash values across executions of your
///   program. `Hasher` is usually randomly seeded, which means it will return
///   different values on every new execution of your program. The hash
///   algorithm implemented by `Hasher` may itself change between any two
///   versions of the standard library.
public struct Hasher {

    private var hashed: Int
    /// Creates a new hasher.
    ///
    /// The hasher uses a per-execution seed value that is set during process
    /// startup, usually from a high-quality random source.
    public init() {
        self.hashed = 0
    }
    
    fileprivate mutating func combine(hashValue value: Int) {
        self.hashed = self.hashed.addingReportingOverflow(value).partialValue
    }

    /// Adds the given value to this hasher, mixing its essential parts into the
    /// hasher state.
    ///
    /// - Parameter value: A value to add to the hasher.
    public mutating func combine<H>(_ value: H) where H : Hashable {
        self.combine(hashValue: value.hashValue)
    }
    
   

    /// Adds the contents of the given buffer to this hasher, mixing it into the
    /// hasher state.
    ///
    /// - Parameter bytes: A raw memory buffer.
    public mutating func combine(bytes: UnsafeRawBufferPointer) {
        guard let address = bytes.baseAddress else { return }
        self.combine(hashValue: Int(bitPattern: address))
    }

    /// Finalizes the hasher state and returns the hash value.
    ///
    /// Finalizing consumes the hasher: it is illegal to finalize a hasher you
    /// don't own, or to perform operations on a finalized hasher. (These may
    /// become compile-time errors in the future.)
    ///
    /// Hash values are not guaranteed to be equal across different executions of
    /// your program. Do not save hash values to use during a future execution.
    ///
    /// - Returns: The hash value calculated by the hasher.
    public func finalize() -> Int {
        return self.hashed
    }
}

public extension Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(hashValue: self.hashValue)
    }
}
#endif
