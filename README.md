# Swift Patches

![swift >= 4.0](https://img.shields.io/badge/swift-%3E%3D4.0-brightgreen.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

Provides some of the missing classes/method when changing between different Swift versions from Swift 4.0 and above

> Note: As of version 2.0 this package has now been broken in to sub modules so that you can include the bare minimum you need.
You can still include all modules by importing the previous module name 'SwiftPackages'

SwiftPackages:
> Includes all other modules provided by this package

CorePatches:

* **Bool**
    * **Methods**: 
      *  **toggle (Swift < 4.1)**: Flips the value of the bool
* **String.Encoding**
  * **Inits**:
    * init(charSet:) 
      * To take in IANA Character Set Name
* **String**
  * **Inits**:
    * init(contentsOf:foundEncoding)
      * that patches the init(..., usedEncoding) when below Swift 4.1  or calls the init(..., usedEncoding) when above Swift 4.1
    * init(contentsOfFile:foundEncoding)
      * that patches the init(..., usedEncoding) when below Swift 4.1  or calls the init(..., usedEncoding) when above Swift 4.1
    * init(data:foundEncoding) 
      * that patches the init(..., usedEncoding) when below Swift 4.1  or calls the init(..., usedEncoding) when above Swift 4.1
    * init(data:usedEncoding) 
      * to match init(contentsOf:usedEncoding) and  init(contentsOfFile:usedEncoding)
* **Random** - Added random support for **Swift < 4.2** 
  * **Protocols**: RandomNumberGenerator
  * **Classes**: SystemRandomNumberGenerator
  * **Extensions**:
    * **Sequence** - Added shuffled method
    * **Collection** - Added randomElement method
    * **MutableCollection** - Added shuffle method
    * **FixedWidthInteger** - Added random methods
    * **Bool** - Added random methods
* **NSFullUserName**
  * **Swift < 4.2**
    * Uses getpwnam to get the full user name, if this method fails, a fatal error will occur
* **FileManager**
  * **Swift >= 4.2** OR **ObjectiveC Runtime**
    * Added **fileExists**(atPath path: String, isDirectory: inout Bool) -> Bool method
* **Process**
  * **Added Properties**:
    * **executable**: to handle the decision making for getting/setting the value between launchPath and executableURL when switching between swift versions and platforms
    * **currentDirectory**:  to handle the decision making for getting/setting the value between currentDirectoryPath and currentDirectoryURL when switching between swift versions and platforms
  * **Added Methods**:
    * **execute**: to handle the decision making for executing either launch and run when switching between swift versions and platforms
* **Result**:
    * **Swift <= 4.2**: Copied/Modified from Swift Source Code
* **Results**: Protocol that defins any Result object
* **Hasher**:  Provided to not have to keep wrapping method hash(into:) methods in #if !swift(>=4.2)
    * **Swift <= 4.2**: Added fake (Sum) logic for hasher.  It sums the hash value of each object that combines to it, allowing for integer rollover
* **CaseIterable**:  Provided protocol where Swift < 5.2.  
    * **Note**: This does not provide automatic implementation of the protocol as is done within Swift >= 5.2
* **autoreleasepool**: Added basic method for OpenSwift (Non Apple) which just directly calls the body method with no garbage collection.
* **Set**:
    * **Added Properties**:
        * **all**: Addes new static all property where Element inherits CaseIterable.  This property returns a Set of all cases by calling Element.allCases to get a list of all possible values
        * **none**: Addes new static none property to visually indacate an empty set
        
ResultOperators:
* **Protocols**: 
    * **ResultEscapeOptionalFailure**: Protocol used to define Failure error type with method to get error for object not found
* **Operators**:
    * **Results<SuccessResult, FailureResult>^**: Returns the SuccessResult or throws FailureResult
    * **Results<SuccessResult?, FailureResult>^!**: Returns the SuccessResult! or throws Failure
    * **Results<SuccessResult?, FailureResult>^?** where Failure: ResultEscapeOptionalFailure: Returns the SuccessResult if not nil, or throws ResultsEscapeOptionalFailure.objectIsNil  or throws FailureResult
    
NumericPatchs:

* **AdditiveArithmetic** - Added support for Swift < 5.0
  * Added implementation to Int, Int8, Int16, Int32, Int64, UInt, UInt8, UInt16, UInt32, UInt64, Float, Double, Decimal
* **BinaryInteger**:
  * **Swift < 5.0**
    * **Added Methods**:
        * **isMultiple(of:)**: Returns `true` if this value is a multiple of the given value, and `false` otherwise. 

SequencePatches:

* **Sequence**
  * Added allEquals method (Not a patch function, but a nice simple helper)
  * **Swift < 4.1**
    * Added compactMap method
  * **Swift < 4.2**
    * Added allSatisfy method
* **Collection**
  * **Swift < 4.2**
    * Added firstIndex(where:) method
    * Added firstIndex(of:) method on Elements implementing Equatable
* **Array**
  * **Swift < 4.2**
    * Added removeAll method
* **Dictionary**:
  * **Swift < 5.0**
    * **Added Methods**:
        * **compactMapValues**: Returns a new dictionary containing only the key-value pairs that have non-`nil` values as the result of transformation by the given closure. 

## Authors

* **Tyler Anger** - *Initial work* - [TheAngryDarling](https://github.com/TheAngryDarling)

## License

*Copyright 2020 Tyler Anger*

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

[HERE](LICENSE.md) or [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## Acknowledgments

Based on and in some cases copied/modified from [Swift Source Code](https://github.com/apple/swift/) to ensure similar standards when dealing with missing objects, methods, and properties
