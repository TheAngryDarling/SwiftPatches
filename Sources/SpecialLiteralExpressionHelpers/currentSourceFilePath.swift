//
//  currentSourceFilePath.swift
//  SpecialLiteralExpressionHelpers
//
//  Created by Tyler Anger on 2021-04-22.
//

import Foundation

#if swift(>=5.3)
/// Returns the StaticString of the path to the source code file of the calling method
/// Will choose either #filePath if swift >= 5.3 otherwise use #file
///
/// Note: This method is not intended for use as a default value of an argument as it will
/// return the path to the file where the method is and not to the file calling the method
public func currentSourceFilePath(_ path: StaticString = #filePath) -> StaticString {
    return path
}
#else
/// Returns the StaticString of the path to the source code file of the calling method
/// Will choose either #filePath if swift >= 5.3 otherwise use #file
///
/// Note: This method is not intended for use as a default value of an argument as it will
/// return the path to the file where the method is and not to the file calling the method
public func currentSourceFilePath(_ path: StaticString = #file) -> StaticString {
    return path
}
#endif

