# SwiftPatches
![swift >= 4.0](https://img.shields.io/badge/swift-%3E%3D4.0-brightgreen.svg)
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

Provides some of the missing classes/method when changing between different swift versions

Current supported fixed:
* **Random** - Added random support for **Swift < 4.2** (RandomNumberGenerator, SystemRandomNumberGenerator)
  * **Sequence** - Added shuffled method
  * **Collection** - Added randomElement method
  * **MutableCollection** - Added shuffle method
  * **FixedWidthInteger** - Added random methods
  * **Bool** - Added random methods
* **Bool**
  * **Swift < 4.1**
    * Added toggle method
* **Sequence**
  * Added allEquals method (Not a patch function, but a nice simple helper)
  * **Swift < 4.2**
    * Added allSatisfy method
* **Collection**
  * **Swift < 4.2**
    * Added firstIndex(where:) method
    * Added firstIndex(of:) method on Elements implementing Equatable
* **Array**
  * **Swift < 4.1**
    * Added compactMap method
  * **Swift < 4.2**
    * Added removeAll method
* **FileManager**
  * **Swift >= 4.2** OR **ObjectiveC Runtime**
    * Added fileExists(atPath path: String, isDirectory: inout Bool) -> Bool method

## Authors

* **Tyler Anger** - *Initial work* - [TheAngryDarling](https://github.com/TheAngryDarling)

## License

This project is licensed under Apache License v2.0 - see the [LICENSE.md](LICENSE.md) file for details
