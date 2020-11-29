//
//  URLResult.swift
//  MoreResults
//
//  Created by Tyler Anger on 2020-11-25.
//
import CorePatches
import Foundation
#if swift(>=4.1)
    #if canImport(FoundationXML)
        import FoundationNetworking
    #endif
#endif

public typealias URLResult<Success, Failure> = DetailedResult<Success, Failure, URL> where Failure: Error

