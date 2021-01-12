import XCTest
#if swift(>=4.1)
    #if canImport(FoundationXML)
        import FoundationNetworking
    #endif
#endif
@testable import SwiftPatches


class SwiftPatchesTests: XCTestCase {
    
    static let packageRootPath: String = String(URL(fileURLWithPath: #file).pathComponents
        .prefix(while: { $0 != "Tests" }).joined(separator: "/").dropFirst())
    
    static let testPackageRootPath: String = packageRootPath + "/Tests"
    static let testPackagePath: String = String(URL(fileURLWithPath: #file).pathComponents.dropLast().joined(separator: "/").dropFirst())
    
    func testFileExistsIsDirectory() {
        var isDir: Bool = false
        _ = FileManager.default.fileExists(atPath: SwiftPatchesTests.testPackageRootPath, isDirectory: &isDir)
        XCTAssert(isDir, "Expected to find directory")
    }

    func testFirstIndex() {
        let testIdx: Int = 2
        let ary: [Int] = [1,2,3,4,5]
        let idx = ary.firstIndex(where: { $0 == ary[testIdx]})
        XCTAssert(idx == testIdx, "Expected to find index of \(testIdx)")
    }
    
    func testRandomGenerator() {
        var generator: SystemRandomNumberGenerator = SystemRandomNumberGenerator()
        
        var vals: [UInt64] = []
        for _ in 0..<10 {
            let val = generator.next()
            XCTAssert(!vals.contains(val), "Value \(val) already existes in array \(vals)")
            vals.append(val)
        }
        
    }
    
    func testRandomCollectionElement() {
        var ary: [Int] = [1,2,3,4,5]
        ary.shuffle()
        XCTAssert(ary.randomElement() != nil, "Expected value when selecting random element from array")
    }
    
    func testRandomBool() {
        
        var randBools: [Bool] = []
        
        for _ in 0..<30 {
            randBools.append(Bool.random())
        }
        XCTAssert(!randBools.allEquals(), "All bools in the array were of the same value (\(randBools[0]).  There should be some of each value)")
    }
    
    func testProcess() {
        let exec = URL(fileURLWithPath: "/bin/ls")
        do {
            let process = Process()
            process.executable = exec
            process.currentDirectory = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            let pipe = Pipe()
            #if os(macOS)
            process.standardInput = FileHandle.nullDevice
            #endif
            process.standardOutput = pipe
            process.standardOutput = pipe
            
            try process.execute()
            process.waitUntilExit()
            
            XCTAssert(process.terminationStatus == 0, "Process failed to execute")
            
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            let str = String(data: data, encoding: .utf8)!
            print(str)
            
            
            
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testFullUserName() {
        let fName = NSFullUserName()
        print(fName)
    }
    
    func testCharSetStringEncoding() {
        let commonNames: [String] = ["UTF8", "UTF-8", "UTF16", "UTF-16", "UNICODE", "ASCII","Windows-1250","Windows1250"]
        for name in commonNames {
            XCTAssertNotNil(String.Encoding(charSet: name), "Unable to find String.Encoding for character set '\(name)'")
       }
        XCTAssertNil(String.Encoding(charSet: "BOGUS-ENCODING"))
    }
    
    func testStringInitContentsOf() {
        var enc: String.Encoding = .utf8
        do {
            _ = try String(contentsOfFile: #file, foundEncoding: &enc)
        } catch {
            XCTFail("\(error)")
        }
        do {
            _ = try String(contentsOf: URL(fileURLWithPath: #file), foundEncoding: &enc)
        } catch {
            XCTFail("\(error)")
        }
        do {
            _ = try String(contentsOf: URL(string: "http://www.google.com/")!, foundEncoding: &enc)
        } catch {
            XCTFail("\(error)")
        }
        
        do {
            
            _ = try String(data: try Data(contentsOf: URL(fileURLWithPath: #file)), foundEncoding: &enc)
        } catch {
            XCTFail("\(error)")
        }
        
        do {
            
            _ = try String(data: try Data(contentsOf: URL(fileURLWithPath: #file)), usedEncoding: &enc)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testResult() {
        enum Err: Swift.Error {
            case testError
        }
        var r = Result<Int, Err>.success(1)
        print(r)
        r = .failure(.testError)
        print(r)
    }
    
    func testIntIsMultipleOf() {
        XCTAssertTrue(0.isMultiple(of: 0))
        XCTAssertTrue(10.isMultiple(of: 5))
        XCTAssertFalse(3.isMultiple(of: 2))
    }
    
    func testDictionaryCompactMapValues() {
        let dict: [String: String] = ["1": "1", "2": "@", "3": "3", "4": "$"]
        let dict2 = dict.compactMapValues({ return Int($0) })
        XCTAssertTrue(dict2 == ["1": 1, "3": 3])
        
    }
    
    func testHasher() {
        if true {
            let value = true
            let valueType = "\(type(of: value))"
            var hasher = Hasher()
            value.hash(into: &hasher)
            let hash = hasher.finalize()
            print("\(valueType) Hasher Value: \(hash)")
        }
        if true {
            let value = "Hello World"
            let valueType = "\(type(of: value))"
            var hasher = Hasher()
            value.hash(into: &hasher)
            let hash = hasher.finalize()
            print("\(valueType) Hasher Value: \(hash)")
        }
        if true {
            let value = UInt(123)
            let valueType = "\(type(of: value))"
            var hasher = Hasher()
            value.hash(into: &hasher)
            let hash = hasher.finalize()
            print("\(valueType) Hasher Value: \(hash)")
        }
        if true {
            let value = -123
            let valueType = "\(type(of: value))"
            var hasher = Hasher()
            value.hash(into: &hasher)
            let hash = hasher.finalize()
            print("\(valueType) Hasher Value: \(hash)")
        }
        if true {
            let value = 5.3
            let valueType = "\(type(of: value))"
            var hasher = Hasher()
            value.hash(into: &hasher)
            let hash = hasher.finalize()
            print("\(valueType) Hasher Value: \(hash)")
        }
    }

    func testCaseIterable() {
        enum TestEnum: String, CaseIterable {
            case case1
            case case2
            case case3
            
            #if !swift(>=5.2)
            public static var allCases: Array<TestEnum> {
                var rtn = Array<TestEnum>()
                rtn.append(.case1)
                rtn.append(.case2)
                rtn.append(.case3)
                return rtn
            }
            #endif
        }
        
        let allCases = TestEnum.allCases
        XCTAssertTrue(allCases.contains(.case1))
        XCTAssertTrue(allCases.contains(.case2))
        XCTAssertTrue(allCases.contains(.case3))
        
    }
    
    func testAutoreleasepool() {
        autoreleasepool {
            let _ : Bool = true
            let _ : String = "Testing"
        }
    }
    
    func testSetsAll() {
        enum TestEnum: String, CaseIterable {
            case case1
            case case2
            case case3
            
            #if !swift(>=5.2)
            public static var allCases: Array<TestEnum> {
                var rtn = Array<TestEnum>()
                rtn.append(.case1)
                rtn.append(.case2)
                rtn.append(.case3)
                return rtn
            }
            #endif
        }
        
        let set = Set<TestEnum>.all
        
        for val in TestEnum.allCases {
            XCTAssertTrue(set.contains(val))
        }
    }
    
    func testResultTypes() {
        enum BaseErrors: Swift.Error {
            case fail
        }
        enum Errors: Swift.Error, ResultEscapeOptionalFailure {
            case fail
            case notfound
            
            static func getObjectIsNilError(for results: Result<Bool?, Errors>) -> Error {
                return Errors.notfound
            }
        }
        enum URLErrors: Swift.Error, ResultEscapeOptionalFailure {
            case fail
            case notfound(URL)
            
            static func getObjectIsNilError(for results: URLResult<Bool?, URLErrors>) -> Error {
                return URLErrors.notfound(results.details)
            }
        }
        enum URLRequestErrors: Swift.Error, ResultEscapeOptionalFailure {
            case fail
            case notfound(URLRequestResponseDetails)
            
            static func getObjectIsNilError(for results: URLRequestResult<Bool?, URLRequestErrors>) -> Error {
                return URLRequestErrors.notfound(results.details)
            }
        }
        
        if true {
            let successResult = Result<Bool, Errors>.success(true)
            XCTAssertNoThrow(try successResult^)
            let optSuccessResult1 = Result<Bool?, BaseErrors>.success(nil)
            XCTAssertNoThrow(try optSuccessResult1^)
            let optSuccessResult2 = Result<Bool?, BaseErrors>.success(false)
            XCTAssertNoThrow(try optSuccessResult2^!)
            let optSuccessResult3 = Result<Bool?, Errors>.success(nil)
            XCTAssertThrowsError(try optSuccessResult3^?)
            let failureResult = Result<Bool, Errors>.failure(.fail)
            XCTAssertThrowsError(try failureResult^)
            let optFailureResult = Result<Bool?, Errors>.failure(.fail)
            XCTAssertThrowsError(try optFailureResult^)
        }
        
        if true {
            let details = URL(string: "http://www.google.com")!
            let successResult = URLResult<Bool, URLErrors>.success(true,
                                                                   withDetails: details)
            XCTAssertNoThrow(try successResult^)
            let optSuccessResult1 = URLResult<Bool?, BaseErrors>.success(nil,
                                                                         withDetails: details)
            XCTAssertNoThrow(try optSuccessResult1^)
            let optSuccessResult2 = URLResult<Bool?, BaseErrors>.success(false,
                                                                         withDetails: details)
            XCTAssertNoThrow(try optSuccessResult2^!)
            let optSuccessResult3 = URLResult<Bool?, URLErrors>.success(nil,
                                                                        withDetails: details)
            XCTAssertThrowsError(try optSuccessResult3^?)
            let failureResult = URLResult<Bool, URLErrors>.failure(.fail,
                                                                   withDetails: details)
            XCTAssertThrowsError(try failureResult^)
            let optFailureResult = URLResult<Bool?, URLErrors>.failure(.fail,
                                                                       withDetails: details)
            XCTAssertThrowsError(try optFailureResult^)
        }
        
        if true {
            let testURL = URL(string: "http://www.google.com")!
            let request = URLRequest(url: testURL)
            let details = URLRequestResponseDetails(request: request,
                                                    responseDetails: .http(url: testURL,
                                                                           mimeType: "text/html",
                                                                           textEncodingName: "utf8",
                                                                           suggestedFileName: nil,
                                                                           expectedContentLength: -1,
                                                                           httpDetails: .init(statusCode: 200)))
            
            let successResult = URLRequestResult<Bool, URLRequestErrors>.success(true,
                                                                                 withDetails: details)
            XCTAssertNoThrow(try successResult^)
            let optSuccessResult1 = URLRequestResult<Bool?, URLRequestErrors>.success(nil,
                                                                                      withDetails: details)
            XCTAssertNoThrow(try optSuccessResult1^)
            let optSuccessResult2 = URLRequestResult<Bool?, BaseErrors>.success(false,
                                                                                withDetails: details)
            XCTAssertNoThrow(try optSuccessResult2^!)
            let optSuccessResult3 = URLRequestResult<Bool?, URLRequestErrors>.success(nil,
                                                                                      withDetails: details)
            XCTAssertThrowsError(try optSuccessResult3^?)
            let failureResult = URLRequestResult<Bool, URLRequestErrors>.failure(.fail,
                                                                                 withDetails: details)
            XCTAssertThrowsError(try failureResult^)
            let optFailureResult = URLRequestResult<Bool?, URLRequestErrors>.failure(.fail,
                                                                                     withDetails: details)
            XCTAssertThrowsError(try optFailureResult^)
        }
    }
    
    func testIdentifiableObject() {
        struct StructObject: Identifiable {
            let id: Int
        }
        class ClassObject: Identifiable { }
        
        let struct1 = StructObject(id: 1)
        let struct2 = StructObject(id: 2)
        let structCopy = struct1
        
        XCTAssertNotEqual(struct1.id, struct2.id, "Struct Id's should not equal")
        XCTAssertEqual(struct1.id, structCopy.id, "Struct Id's should equal")
        
        let class1 = ClassObject()
        let class2 = ClassObject()
        let classCopy = class1
        
        
        XCTAssertNotEqual(class1.id, class2.id, "Class Id's should not equal")
        XCTAssertEqual(class1.id, classCopy.id, "Class Id's should equal")
        
        
        
    }
    
    static var allTests = [
        ("testFileExistsIsDirectory", testFileExistsIsDirectory),
        ("testFirstIndex", testFirstIndex),
        ("testRandomCollectionElement", testRandomCollectionElement),
        ("testRandomBool", testRandomBool),
        ("testProcess", testProcess),
        ("testFullUserName", testFullUserName),
        ("testCharSetStringEncoding", testCharSetStringEncoding),
        ("testStringInitContentsOf", testStringInitContentsOf),
        ("testResult", testResult),
        ("testIntIsMultipleOf", testIntIsMultipleOf),
        ("testDictionaryCompactMapValues", testDictionaryCompactMapValues),
        ("testHasher", testHasher),
        ("testCaseIterable", testCaseIterable),
        ("testAutoreleasepool", testAutoreleasepool),
        ("testSetsAll", testSetsAll),
        ("testResultTypes", testResultTypes)
    ]
}
