//
//  String.Encoding+SwiftPatches.swift
//  StringPatches
//
//  Created by Tyler Anger on 2019-10-03.
//

import Foundation
import CoreFoundation

fileprivate extension String {
    /// CFString version of the current string
    var cfString: CFString {
        let chars = Array(self.utf16)
        let cfStr = CFStringCreateWithCharacters(nil, chars, self.utf16.count)
        let str = CFStringCreateCopy(nil, cfStr)!
        return str
    }
}
public extension String.Encoding {
    // Map selected IANA character set names to encodings, see
    // https://www.iana.org/assignments/character-sets/character-sets.xhtml
    init?(charSet: String) {
        // https://stackoverflow.com/questions/44730379/how-can-i-convert-a-string-such-as-iso-8859-1-to-its-string-encoding-counte
        
        let cfe = CFStringConvertIANACharSetNameToEncoding(charSet.cfString)
        if cfe == kCFStringEncodingInvalidId { return nil }
        let se = CFStringConvertEncodingToNSStringEncoding(cfe)
        
        self.init(rawValue: se)
    }
}
