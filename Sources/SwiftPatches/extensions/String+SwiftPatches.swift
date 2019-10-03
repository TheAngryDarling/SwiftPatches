//
//  String+SwiftPatches.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2019-10-03.
//
// Note: This code has been taken and slightly modified from
// https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSString.swift

import Foundation
import Dispatch
import CoreFoundation
#if swift(>=4.1)
    #if canImport(FoundationXML)
        import FoundationNetworking
    #endif
#endif

#if !swift(>=5.1)
public let NSDebugDescriptionErrorKey: String = "NSDebugDescription"
#endif

public extension String {
    /// Creates a string representing the data given
    /// - Parameter data: The data representaton of the text to load
    /// - Parameter possibletTextEncoding: possible text encoding when data was download from the web
    /// - Parameter encoding: The encoding used to read the text
    private init(data: Data, possibletTextEncoding: String?, foundEncoding encoding: inout String.Encoding) throws {
        
        // Look for a BOM (Byte Order Marker) to try and determine the text Encoding, this also skips
        // over the bytes. This takes precedence over the textEncoding in the http header
        // https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSString.swift
        if data.count >= 4 && data[0] == 0xFF && data[1] == 0xFE && data[2] == 0x00 && data[3] == 0x00 {
            encoding = String.Encoding.utf32LittleEndian
        }
        else if data.count >= 2 && data[0] == 0xFE && data[1] == 0xFF {
            encoding = String.Encoding.utf16BigEndian
        }
        else if data.count >= 2 && data[0] == 0xFF && data[1] == 0xFE {
            encoding = String.Encoding.utf16LittleEndian
        }
        else if data.count >= 4 && data[0] == 0x00 && data[1] == 0x00 && data[2] == 0xFE && data[3] == 0xFF {
            encoding = String.Encoding.utf32BigEndian
        }
        else if let charSet = possibletTextEncoding, let textEncoding = String.Encoding(charSet: charSet) {
            encoding = textEncoding
        } else {
            //Need to work on more conditions. This should be the default
            encoding = String.Encoding.utf8
        }
        
        guard let s = String(data: data, encoding: encoding) else {
            throw NSError(domain: NSCocoaErrorDomain, code: CocoaError.fileReadInapplicableStringEncoding.rawValue, userInfo: [
            NSDebugDescriptionErrorKey : "Unable to create a string using the specified encoding."
            ])
        }
        self = s
    }
    
    /// Creates a string representing the data from the file
    /// - Parameter url: The url to the text to load
    /// - Parameter encoding: The encoding used to read the text
    init(contentsOf url: URL, foundEncoding encoding: inout String.Encoding) throws {
        #if _runtime(_ObjC) || swift(>=4.1)
        try self.init(contentsOf: url, usedEncoding: &encoding)
        #else
        if url.isFileURL {
            try self.init(data: try Data(contentsOf: url), possibletTextEncoding: nil, foundEncoding: &encoding)
        } else {
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfig)
            
            let semaphore = DispatchSemaphore(value: 0)
            var data: Data!
            var textEncoding: String? = nil
            var err: Error? = nil
            
            let task = session.dataTask(with: url) { dta, response, error in
                
                data = dta
                err = error
                if let resp = response as? HTTPURLResponse, error == nil {
                    textEncoding = resp.textEncodingName
                }
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
            
            if let e = err { throw e }
            
            try self.init(data: data, possibletTextEncoding: textEncoding, foundEncoding: &encoding)
        }
        #endif
    }
    
    /// Creates a string representing the data from the file
    /// - Parameter file: The path to the text file to load
    /// - Parameter encoding: The encoding used to read the text
    init(contentsOfFile file: String, foundEncoding encoding: inout String.Encoding) throws {
        try self.init(contentsOf: URL(fileURLWithPath: file), foundEncoding: &encoding)
    }
    
    /// Creates a string representing the data given
    /// - Parameter data: The data representaton of the text to load
    /// - Parameter encoding: The encoding used to read the text
    init(data: Data, foundEncoding encoding: inout String.Encoding) throws {
        try self.init(data: data, possibletTextEncoding: nil, foundEncoding: &encoding)
    }
    
    /// Creates a string representing the data given
    /// - Parameter data: The data representaton of the text to load
    /// - Parameter encoding: The encoding used to read the text
    init(data: Data, usedEncoding encoding: inout String.Encoding) throws {
        try self.init(data: data, possibletTextEncoding: nil, foundEncoding: &encoding)
    }
}
