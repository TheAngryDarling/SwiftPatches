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

    static var allTests = [
        ("testFileExistsIsDirectory", testFileExistsIsDirectory),
        ("testFirstIndex", testFirstIndex),
        ("testRandomCollectionElement", testRandomCollectionElement),
        ("testRandomBool", testRandomBool),
        ("testProcess", testProcess),
        ("testFullUserName", testFullUserName)
    ]
}
