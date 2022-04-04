//
//  URLRequestResult.swift
//  MoreResults
//
//  Created by Tyler Anger on 2020-11-25.
//
import Foundation
#if swift(>=4.1)
    #if canImport(FoundationXML)
        import FoundationNetworking
    #endif
#endif
import ResultPatches


public struct URLRequestResponseDetails {
    
    public enum URLResponseDetails {
        public struct HTTPResponseDetails {
            /// The response’s HTTP status code.
            ///
            /// See RFC 2616 for details.
            public let statusCode: Int
            /// All HTTP header fields of the response.
            ///
            /// The value of this property is a dictionary that contains all the HTTP header fields received as part of the server’s response. By examining this dictionary, clients can see the “raw” header information returned by the HTTP server.
            /// The keys in this dictionary are the header field names, as received from the server. See RFC 2616 for a list of commonly used HTTP header fields.
            /// HTTP headers are case insensitive. To simplify your code, URL Loading System canonicalizes certain header field names into their standard form. For example, if the server sends a content-length header, it’s automatically adjusted to be Content-Length.
            /// Because this property is a standard Swift dictionary, its keys are case-sensitive. To perform a case-insensitive header lookup, use the value(forHTTPHeaderField:) method instead.
            public let allHeaderFields: [AnyHashable : Any]
            
            /// Initialize a new instance with the data from the given HTTPURLResponse
            public init(_ response: HTTPURLResponse) {
                self.statusCode = response.statusCode
                self.allHeaderFields = response.allHeaderFields
            }
            public init(statusCode: Int,
                        allHeaderFields: [AnyHashable : Any] = [:]) {
                self.statusCode = statusCode
                self.allHeaderFields = allHeaderFields
            }
        }
        
        case base(url: URL?,
                  mimeType: String?,
                  textEncodingName: String?,
                  suggestedFileName: String?,
                  expectedContentLength: Int64?)
        case http(url: URL?,
                  mimeType: String?,
                  textEncodingName: String?,
                  suggestedFileName: String?,
                  expectedContentLength: Int64?,
                  httpDetails: HTTPResponseDetails)
        
        /// The URL for the response.
        public var url: URL? {
            switch self {
                case .base(url: let rtn,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: _): return rtn
                case .http(url: let rtn,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: _,
                           httpDetails: _): return rtn
            }
        }
        
        /// The MIME type of the response.
        ///
        /// The MIME type is often provided by the response’s originating source. However, that value may be changed or corrected by a protocol implementation if it can be determined that the response’s source reported the information incorrectly.
        ///
        /// If the response’s originating source does not provide a MIME type, an attempt to guess the MIME type may be made.
        public var mimeType: String? {
            switch self {
                case .base(url: _,
                           mimeType: let rtn,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: _): return rtn
                case .http(url: _,
                           mimeType: let rtn,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: _,
                           httpDetails: _): return rtn
            }
        }
        
        /// The name of the text encoding provided by the response’s originating source.
        ///
        /// If no text encoding was provided by the protocol, this property’s value is nil.
        ///
        /// You can convert this string to a CFStringEncoding value by calling CFStringConvertIANACharSetNameToEncoding(_:). You can subsequently convert that value to an NSStringEncoding value by calling CFStringConvertEncodingToNSStringEncoding(_:).
        public var textEncodingName: String? {
            switch self {
                case .base(url: _,
                           mimeType: _,
                           textEncodingName: let rtn,
                           suggestedFileName: _,
                           expectedContentLength: _): return rtn
                case .http(url: _,
                           mimeType: _,
                           textEncodingName: let rtn,
                           suggestedFileName: _,
                           expectedContentLength: _,
                           httpDetails: _): return rtn
            }
        }
        
        /// A suggested filename for the response data.
        ///
        /// Accessing this property attempts to generate a filename using the following information, in order:
        ///
        ///     1. A filename specified using the content disposition header.
        ///     2. The last path component of the URL.
        ///     3. The host of the URL.
        ///
        /// If the host of URL can't be converted to a valid filename, the filename “unknown” is used.
        /// In most cases, this property appends the proper file extension based on the MIME type. Accessing this property always returns a valid filename regardless of whether the resource is saved to disk.
        public var suggestedFileName: String? {
            switch self {
                case .base(url: _,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: let rtn,
                           expectedContentLength: _): return rtn
                case .http(url: _,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: let rtn,
                           expectedContentLength: _,
                           httpDetails: _): return rtn
            }
        }
        
        /// The expected length of the response’s content.
        ///
        /// This property’s value is NSURLResponseUnknownLength if the length can’t be determined.
        /// Some protocol implementations report the content length as part of the response, but not all protocols guarantee to deliver that amount of data. Your app should be prepared to deal with more or less data.
        public var expectedContentLength: Int64? {
            switch self {
                case .base(url: _,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: let rtn): return rtn
                case .http(url: _,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: let rtn,
                           httpDetails: _): return rtn
            }
        }
        /// Provides http details if this was an HTTPURLResponse
        public var httpDetails: HTTPResponseDetails? {
            switch self {
                case .base(url: _,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: _): return nil
                case .http(url: _,
                           mimeType: _,
                           textEncodingName: _,
                           suggestedFileName: _,
                           expectedContentLength: _,
                           httpDetails: let rtn): return rtn
            }
        }
        
        /// Initialize a new instance with the given URLResponse
        public init(_ response: URLResponse) {
            let url = response.url
            let mimeType = response.mimeType
            let textEncodingName = response.textEncodingName
            let suggestedFilename = response.suggestedFilename
            let expectedContentLength = response.expectedContentLength
            
            if let resp = response as? HTTPURLResponse {
                self = .http(url: url,
                             mimeType: mimeType,
                             textEncodingName: textEncodingName,
                             suggestedFileName: suggestedFilename,
                             expectedContentLength: expectedContentLength,
                             httpDetails: .init(resp))
            } else {
                self = .base(url: url,
                             mimeType: mimeType,
                             textEncodingName: textEncodingName,
                             suggestedFileName: suggestedFilename,
                             expectedContentLength: expectedContentLength)
            }
        }
        /// If response is not nil, initialize a new instance with the given URLResponse
        public init?(_ response: URLResponse?) {
            guard let r = response else { return nil }
            self.init(r)
        }
    }
    
    public let request: URLRequest
    public let responseDetails: URLResponseDetails?
    
    /// initialize a new instance with the given URLRequest and URLResponse
    public init(request: URLRequest,
                response: URLResponse? = nil) {
        self.request = request
        self.responseDetails = URLResponseDetails(response)
    }
    /// initialize a new instance with the given URLRequest and URLResponse
    public init(request: URLRequest,
                responseDetails: URLResponseDetails? = nil) {
        self.request = request
        self.responseDetails = responseDetails
    }
}

public typealias URLRequestResult<Success, Failure> = DetailedResult<Success, Failure, URLRequestResponseDetails> where Failure: Error
