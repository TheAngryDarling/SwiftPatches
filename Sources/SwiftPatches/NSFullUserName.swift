//
//  NSFullUserName.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-07-25.
//

import Foundation

#if !swift(>=4.1.9)
    /// Returns a string containing the full name of the current user.
    ///
    /// This uses getpwnam method to get the full user name.  If nothing is reutrned from getpwnam a fatal error will occur
    /// - Returns: A string containing the full name of the current user.
    public func NSFullUserName() -> String {
        if let pw = getpwnam(NSUserName()) {
            let str = String(cString: pw.pointee.pw_gecos)
            return str
        } else {
            fatalError("Unable to find user display name.")
        }
    }
#endif
