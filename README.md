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

NumericPatchs:

* **AdditiveArithmetic** - Added support for Swift < 5.0
  * Added implementation to Int, Int8, Int16, Int32, Int64, UInt, UInt8, UInt16, UInt32, UInt64

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
  

## Authors

* **Tyler Anger** - *Initial work* - [TheAngryDarling](https://github.com/TheAngryDarling)

## License

This project is licensed under Apache License v2.0 - see the [LICENSE.md](LICENSE.md) file for details
