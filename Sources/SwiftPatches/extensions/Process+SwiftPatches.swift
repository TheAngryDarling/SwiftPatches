//
//  Process+SwiftPatches.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-07-25.
//

import Foundation

public extension Process {

    /// The URL to the executable.
    ///
    /// This will figure out which property to use, either launchPath OR executableURL depending on the Swift version and Platform version
    var executable: URL? {
        get {
            #if !swift(>=4.2)
                guard let p = self.launchPath else { return nil }
                return URL(fileURLWithPath: p)
            #else
                if #available(OSX 10.13, *) {
                    return self.executableURL
                } else {
                    guard let p = self.launchPath else { return nil }
                    return URL(fileURLWithPath: p)
                }
            #endif
        }
        set {
            #if !swift(>=4.2)
                if let v = newValue {
                    self.launchPath = v.standardized.resolvingSymlinksInPath().path
                } else {
                    self.launchPath = nil
                }
            #else
                if #available(OSX 10.13, *) {
                    self.executableURL = newValue
                } else {
                    if let v = newValue {
                        self.launchPath = v.standardized.resolvingSymlinksInPath().path
                    } else {
                        self.launchPath = nil
                    }
                }
            #endif
        }
    }
    
    /// The current directory for the receiver.
    ///
    /// This will figure out which property to use, either currentDirectoryPath OR currentDirectoryURL depending on the Swift version and Platform version
    /// If this property isn’t used, the current directory is inherited from the process that created the receiver. This method raises an NSInvalidArgumentException if the receiver has already been launched.
    var currentDirectory: URL {
        get {
            #if !swift(>=4.2)
                return URL(fileURLWithPath: self.currentDirectoryPath)
            #else
                if #available(OSX 10.13, *) {
                    return self.currentDirectoryURL
                } else {
                    return URL(fileURLWithPath: self.currentDirectoryPath)
                }
            #endif
        }
        set {
            #if !swift(>=4.2)
                self.currentDirectoryPath = newValue.path
            #else
                if #available(OSX 10.13, *) {
                    self.currentDirectoryURL = newValue
                } else {
                    self.currentDirectoryPath = newValue.standardized.resolvingSymlinksInPath().path
                }
            #endif
        }
    }
    
    /// Runs the task represented by the receiver.
    ///
    /// This will choose which method to excute.  Either the launch or run method depending on the Swift version and Platform version
    /// Raises an NSInvalidArgumentException if the executableURL has not been set or is invalid or if it fails to create a process.
    func execute() throws {
        #if swift(>=5.0)
            if #available(OSX 10.13, *) {
                try self.run()
            } else {
                self.launch()
            }
        #else
            self.launch()
        #endif
    }

    
}
