//
//  AdditiveArithmetic.swift
//  SwiftPatches
//
//  Created by Tyler Anger on 2020-06-09.
//

import Foundation

#if !swift(>=5.0)
public protocol AdditiveArithmetic {
    static var zero: Self { get }
     
    prefix static func + (x: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func += (lhs: inout Self, rhs: Self)
    static func - (lhs: Self, rhs: Self) -> Self
    static func -= (lhs: inout Self, rhs: Self)

}
public extension AdditiveArithmetic {
    static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
    static func -= (lhs: inout Self, rhs: Self) {
        lhs = lhs - rhs
    }
}

extension Int: AdditiveArithmetic {
    public static var zero: Int { return Int() }
}
extension Int8: AdditiveArithmetic {
    public static var zero: Int8 { return Int8() }
}
extension Int16: AdditiveArithmetic {
    public static var zero: Int16 { return Int16() }
}
extension Int32: AdditiveArithmetic {
    public static var zero: Int32 { return Int32() }
}
extension Int64: AdditiveArithmetic {
    public static var zero: Int64 { return Int64() }
}

extension UInt: AdditiveArithmetic {
    public static var zero: UInt { return UInt() }
}
extension UInt8: AdditiveArithmetic {
    public static var zero: UInt8 { return UInt8() }
}
extension UInt16: AdditiveArithmetic {
    public static var zero: UInt16 { return UInt16() }
}
extension UInt32: AdditiveArithmetic {
    public static var zero: UInt32 { return UInt32() }
}
extension UInt64: AdditiveArithmetic {
    public static var zero: UInt64 { return UInt64() }
}

extension Float: AdditiveArithmetic {
    public static var zero: Float { return Float() }
}
extension Double: AdditiveArithmetic {
    public static var zero: Double { return Double() }
}
extension Decimal: AdditiveArithmetic {
    public static var zero: Decimal { return Decimal() }
}


#endif
