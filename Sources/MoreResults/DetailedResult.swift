//
//  DetailedResult.swift
//  MoreResults
//
//  Created by Tyler Anger on 2020-11-28.
//

import Foundation
import CorePatches

public enum DetailedResult<Success, Failure, Details>: Results where Failure: Error {
    public typealias SuccessResult = Success
    public typealias FailureResult = Failure
    
    case success(Success, withDetails: Details)
    case failure(Failure, withDetails: Details)
    
    public var details: Details {
        switch self {
            case .success(_, withDetails: let rtn): return rtn
            case .failure(_, withDetails: let rtn): return rtn
        }
    }
    
    public func get() throws -> Success {
        switch self {
            case .success(let rtn, withDetails: _): return rtn
            case .failure(let err, withDetails: _): throw err
        }
    }
    
    public func map<NewSuccess>(_ transform: (Success) -> NewSuccess) -> DetailedResult<NewSuccess, Failure, Details> {
        switch self {
            case .success(let success, withDetails: let details):
                return .success(transform(success), withDetails: details)
            case .failure(let failure, withDetails: let details):
                return .failure(failure, withDetails: details)
        }
    }
    
    public func mapError<NewFailure>(_ transform: (Failure) -> NewFailure) -> DetailedResult<Success, NewFailure, Details> {
        switch self {
            case .success(let success, withDetails: let details):
                return .success(success, withDetails: details)
            case .failure(let failure, withDetails: let details):
                return .failure(transform(failure), withDetails: details)
        }
    }
    
    public func mapDetails<NewDetails>(_ transform: (Details) -> NewDetails) -> DetailedResult<Success, Failure, NewDetails> {
        switch self {
            case .success(let success, withDetails: let details):
                return .success(success, withDetails: transform(details))
            case .failure(let failure, withDetails: let details):
                return .failure(failure, withDetails: transform(details))
        }
    }
    
    /// Returns a new result, mapping any success value using the given
    /// transformation and unwrapping the produced result.
    ///
    /// - Parameter transform: A closure that takes the success value and details of the
    ///   instance.
    /// - Returns: A `DetailedResult` instance with the result of evaluating `transform`
    ///   as the new failure value if this instance represents a failure.
    public func flatMap<NewSuccess>(_ transform: (Success, Details) -> DetailedResult<NewSuccess, Failure, Details>) -> DetailedResult<NewSuccess, Failure, Details> {
        switch self {
            case .success(let success, withDetails: let details):
                return transform(success, details)
            case .failure(let failure, withDetails: let details):
                return .failure(failure, withDetails: details)
        }
    }

    /// Returns a new result, mapping any failure value using the given
    /// transformation and unwrapping the produced result.
    ///
    /// - Parameter transform: A closure that takes the failure value and details of the
    ///   instance.
    /// - Returns: A `DetailedResult` instance, either from the closure or the previous
    ///   `.success`.
    public func flatMapError<NewFailure>(_ transform: (Failure, Details) -> DetailedResult<Success, NewFailure, Details>) -> DetailedResult<Success, NewFailure, Details> {
        switch self {
            case .success(let success, withDetails: let details):
                return .success(success, withDetails: details)
            case .failure(let failure, withDetails: let details):
                return transform(failure, details)
        }
    }
    
    /// Returns a new result, mapping any failure value using the given
    /// transformation and unwrapping the produced result.
    ///
    /// - Parameter transform: A closure that takes the all values of the
    ///   instance.
    /// - Returns: A `DetailedResult` instance, either from the closure or the previous
    ///   `.success`.
    public func flatMapDetails<NewDetails>(_ transform: (Success?, Failure?, Details) -> DetailedResult<Success, Failure, NewDetails>) -> DetailedResult<Success, Failure, NewDetails> {
        switch self {
            case .success(let success, withDetails: let details):
                return transform(success, nil, details)
            case .failure(let failure, withDetails: let details):
                return transform(nil, failure, details)
        }
    }
}
