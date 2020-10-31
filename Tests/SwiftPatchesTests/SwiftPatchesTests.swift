import XCTest
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
        ("testCaseIterable", testCaseIterable)
    ]
}
