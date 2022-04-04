//
//  currentSourceFileID.swift
//  SpecialLiteralExpressionHelpers
//
//  Created by Tyler Anger on 2021-04-24.
//

import Foundation

/*
#if swift(>=5.3)
/// Returns the StaticString of the fileID of the source code file of the calling method
/// Will choose either #fileID if swift >= 5.3 otherwise will build using stack trace and #file
public func currentSourceFileID(_ path: StaticString = #fileID) -> StaticString {
    return path
}
#else
/// Returns the StaticString of the fileID of the source code file of the calling method
/// Will choose either #fileID if swift >= 5.3 otherwise will build using stack trace and #file
///
/// Note: When running on OpenSwift < 4.1 this will result in N/A/{FileName}
public func currentSourceFileID(_ path: StaticString = #file) -> StaticString {
    var fileName = "\(path)"
    if let r = fileName.range(of: "/", options: .backwards) {
        let name = String(fileName[r.upperBound...])
        if !name.isEmpty {
            fileName = name
        }
    }
    var module: String = "N/A"
    #if (_runtime(_ObjC) || swift(>=4.1))
    
    #endif
    
    let id: String = module + "/" + fileName
    
    return StaticString(id)
}
#endif
*/
