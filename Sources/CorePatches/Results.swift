//
//  Results.swift
//  CorePatches
//
//  Created by Tyler Anger on 2020-11-28.
//

import Foundation

public protocol Results {
    associatedtype SuccessResult
    associatedtype FailureResult: Error
    
    /// Returns the success value as a throwing expression.
    ///
    /// Use this method to retrieve the value of this result if it represents a
    /// success, or to catch the value if it represents a failure.
    ///
    ///     let integerResult: Result<Int, Error> = .success(5)
    ///     do {
    ///         let value = try integerResult.get()
    ///         print("The value is \(value).")
    ///     } catch error {
    ///         print("Error retrieving the value: \(error)")
    ///     }
    ///     // Prints "The value is 5."
    ///
    /// - Returns: The success value, if the instance represents a success.
    /// - Throws: The failure value, if the instance represents a failure.
    func get() throws -> SuccessResult
    
    /// Returns a new result, mapping any success value using the given
    /// transformation.
    ///
    /// Use this method when you need to transform the value of a `Result`
    /// instance when it represents a success. The following example transforms
    /// the integer success value of a result into a string:
    ///
    ///     func getNextInteger() -> Result<Int, Error> { /* ... */ }
    ///
    ///     let integerResult = getNextInteger()
    ///     // integerResult == .success(5)
    ///     let stringResult = integerResult.map({ String($0) })
    ///     // stringResult == .success("5")
    ///
    /// - Parameter transform: A closure that takes the success value of this
    ///   instance.
    /// - Returns: A `Result` instance with the result of evaluating `transform`
    ///   as the new success value if this instance represents a success.
    func map<NewSuccess>(_ transform: (SuccessResult) -> NewSuccess) -> Self where SuccessResult  == NewSuccess
    
    /// Returns a new result, mapping any failure value using the given
    /// transformation.
    ///
    /// Use this method when you need to transform the value of a `Result`
    /// instance when it represents a failure. The following example transforms
    /// the error value of a result by wrapping it in a custom `Error` type:
    ///
    ///     struct DatedError: Error {
    ///         var error: Error
    ///         var date: Date
    ///
    ///         init(_ error: Error) {
    ///             self.error = error
    ///             self.date = Date()
    ///         }
    ///     }
    ///
    ///     let result: Result<Int, Error> = // ...
    ///     // result == .failure(<error value>)
    ///     let resultWithDatedError = result.mapError({ e in DatedError(e) })
    ///     // result == .failure(DatedError(error: <error value>, date: <date>))
    ///
    /// - Parameter transform: A closure that takes the failure value of the
    ///   instance.
    /// - Returns: A `Result` instance with the result of evaluating `transform`
    ///   as the new failure value if this instance represents a failure.
    func mapError<NewFailure>(_ transform: (FailureResult) -> NewFailure) -> Self where FailureResult == NewFailure
}

public struct _SuccessResultOptionalLock {
    // swiftlint:disable:previous type_name
    internal init() { }
}

public protocol SuccessResultOptional {
    associatedtype SuccessResultWrappedValue
    /// A sad way to lock the implementation of this protocol to within its own library.
    /// This allows for others to test against Nillable but does not allow then to create
    /// new object types that implement it
    static var _successResultOptionalLock: _SuccessResultOptionalLock { get }
    
    init(_ some: SuccessResultWrappedValue)
}

fileprivate protocol _SuccessResultOptional {
    /// Indicates if this optional object is nil or not
    var isSuccessResultNil: Bool { get }
}

extension Optional: SuccessResultOptional, _SuccessResultOptional {
    public static var _successResultOptionalLock: _SuccessResultOptionalLock {
        return _SuccessResultOptionalLock()
    }
    fileprivate var isSuccessResultNil: Bool {
        switch self {
            case .some(_): return false
            case .none: return true
        }
    }
}

public extension Results where SuccessResult: SuccessResultOptional {
    /// Indicator if the results is nil or not.
    ///
    /// Returns an optional Bool.
    /// If returns nil that means this result is a failure.
    /// If true that means that the result value is nil otherwise returns false
    var isSuccessNil: Bool? {
        guard let v = try? self.get() else { return nil }
        return (v as! _SuccessResultOptional).isSuccessResultNil
    }
}
