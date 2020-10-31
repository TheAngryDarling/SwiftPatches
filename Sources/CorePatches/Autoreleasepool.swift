//
//  Autoreleasepool.swift
//  CorePatches
//
//  Created by Tyler Anger on 2020-10-31.
//

import Foundation

#if !_runtime(_ObjC)
public func autoreleasepool<Result>(invoking body: () throws -> Result) rethrows -> Result {
    return try body()
}
#endif
