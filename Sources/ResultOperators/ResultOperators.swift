//
//  ResultOperators.swift
//  
//
//  Created by Tyler Anger on 2020-11-23.
//

import Foundation
import ResultPatches

postfix operator ^
public postfix func ^<R: Results>(results: R) throws -> R.SuccessResult {
    return try results.get()
}

postfix operator ^!
public postfix func ^!<Success, R: Results>(results: R) throws -> Success where R.SuccessResult == Optional<Success> {
    let val = try results.get()
    return val!
}

/// Protocol used to define Failure error type with method to get error for object not found
public protocol ResultEscapeOptionalFailure: Error {
    associatedtype ResultType: Results
    static func getObjectIsNilError(for results: ResultType) -> Error
}

postfix operator ^?
public postfix func ^?<Success, R: Results>(results: R) throws -> Success where R.SuccessResult == Optional<Success>, R.FailureResult: ResultEscapeOptionalFailure, R.FailureResult.ResultType == R {
    let val = try results.get()
    guard let rtn = val else {
        throw R.FailureResult.getObjectIsNilError(for: results)
    }
    return rtn
}
