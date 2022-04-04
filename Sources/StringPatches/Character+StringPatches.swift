//
//  Character+StringPatches.swift
//  StringPatches
//
//  Created by Tyler Anger on 2021-03-26.
//

import Foundation
#if !swift(>=5.0)
public extension Character {
    /// Returns an uppercased version of this character.
      ///
      /// Because case conversion can result in multiple characters, the result
      /// of `uppercased()` is a string.
      ///
      ///     let chars: [Character] = ["e", "é", "и", "π", "ß", "1"]
      ///     for ch in chars {
      ///         print(ch, "-->", ch.uppercased())
      ///     }
      ///     // Prints:
      ///     // e --> E
      ///     // é --> É
      ///     // и --> И
      ///     // π --> Π
      ///     // ß --> SS
      ///     // 1 --> 1
    func uppercased() -> String { return String(self).uppercased() }

      /// Returns a lowercased version of this character.
      ///
      /// Because case conversion can result in multiple characters, the result
      /// of `lowercased()` is a string.
      ///
      ///     let chars: [Character] = ["E", "É", "И", "Π", "1"]
      ///     for ch in chars {
      ///         print(ch, "-->", ch.lowercased())
      ///     }
      ///     // Prints:
      ///     // E --> e
      ///     // É --> é
      ///     // И --> и
      ///     // Π --> π
      ///     // 1 --> 1
    func lowercased() -> String {
        return String(self).lowercased()
        
    }
}
#endif

#if !swift(>=5.0)
public extension Character {
    var unicodeScalars: String.UnicodeScalarView {
        return String(self).unicodeScalars
    }
    
    private var unicodeScalar: Unicode.Scalar {
        return self.unicodeScalars.first!
    }
    /// A Boolean value indicating whether this character represents whitespace,
    /// including newlines.
    ///
    /// For example, the following characters all represent whitespace:
    ///
    /// - "\t" (U+0009 CHARACTER TABULATION)
    /// - " " (U+0020 SPACE)
    /// - U+2029 PARAGRAPH SEPARATOR
    /// - U+3000 IDEOGRAPHIC SPACE
    var isWhitespace: Bool { return CharacterSet.whitespaces.contains(self.unicodeScalar) }

    /// A Boolean value indicating whether this character represents a newline.
    ///
    /// For example, the following characters all represent newlines:
    ///
    /// - "\n" (U+000A): LINE FEED (LF)
    /// - U+000B: LINE TABULATION (VT)
    /// - U+000C: FORM FEED (FF)
    /// - "\r" (U+000D): CARRIAGE RETURN (CR)
    /// - "\r\n" (U+000D U+000A): CR-LF
    /// - U+0085: NEXT LINE (NEL)
    /// - U+2028: LINE SEPARATOR
    /// - U+2029: PARAGRAPH SEPARATOR
    var isNewline: Bool { return CharacterSet.newlines.contains(self.unicodeScalar) }
    
    /// A Boolean value indicating whether this character represents punctuation.
    ///
    /// For example, the following characters all represent punctuation:
    ///
    /// - "!" (U+0021 EXCLAMATION MARK)
    /// - "؟" (U+061F ARABIC QUESTION MARK)
    /// - "…" (U+2026 HORIZONTAL ELLIPSIS)
    /// - "—" (U+2014 EM DASH)
    /// - "“" (U+201C LEFT DOUBLE QUOTATION MARK)
    var isPunctuation: Bool {
        return CharacterSet.punctuationCharacters.contains(self.unicodeScalar)
    }

    /// A Boolean value indicating whether this character is considered uppercase.
    ///
    /// Uppercase characters vary under case-conversion to lowercase, but not when
    /// converted to uppercase. The following characters are all uppercase:
    ///
    /// - "É" (U+0045 LATIN CAPITAL LETTER E, U+0301 COMBINING ACUTE ACCENT)
    /// - "И" (U+0418 CYRILLIC CAPITAL LETTER I)
    /// - "Π" (U+03A0 GREEK CAPITAL LETTER PI)
    var isUppercase: Bool {
        return CharacterSet.uppercaseLetters.contains(self.unicodeScalar)
    }

    /// A Boolean value indicating whether this character is considered lowercase.
    ///
    /// Lowercase characters change when converted to uppercase, but not when
    /// converted to lowercase. The following characters are all lowercase:
    ///
    /// - "é" (U+0065 LATIN SMALL LETTER E, U+0301 COMBINING ACUTE ACCENT)
    /// - "и" (U+0438 CYRILLIC SMALL LETTER I)
    /// - "π" (U+03C0 GREEK SMALL LETTER PI)
    var isLowercase: Bool {
        return CharacterSet.lowercaseLetters.contains(self.unicodeScalar)
    }

    /// A Boolean value indicating whether this character changes under any form
    /// of case conversion.
    var isCased: Bool {
        return self.isUppercase || self.isLowercase
    }

    /// A Boolean value indicating whether this character represents a symbol.
    ///
    /// This property is `true` only for characters composed of scalars in the
    /// "Math_Symbol", "Currency_Symbol", "Modifier_Symbol", or "Other_Symbol"
    /// categories in the
    /// [Unicode Standard](https://unicode.org/reports/tr44/#General_Category_Values).
    ///
    /// For example, the following characters all represent symbols:
    ///
    /// - "®" (U+00AE REGISTERED SIGN)
    /// - "⌹" (U+2339 APL FUNCTIONAL SYMBOL QUAD DIVIDE)
    /// - "⡆" (U+2846 BRAILLE PATTERN DOTS-237)
    var isSymbol: Bool  {
        return CharacterSet.symbols.contains(self.unicodeScalar)
    }
    
}
#endif

#if !swift(>=5.0)

let hexValues: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"]
public extension Character {
    /// The numeric value this character represents, if it is a hexadecimal digit.
    ///
    /// Hexadecimal digits include 0-9, Latin letters a-f and A-F, and their
    /// fullwidth compatibility forms. If the character does not represent a
    /// hexadecimal digit, the value of this property is `nil`.
    ///
    ///     let chars: [Character] = ["1", "a", "Ｆ", "g"]
    ///     for ch in chars {
    ///         print(ch, "-->", ch.hexDigitValue)
    ///     }
    ///     // Prints:
    ///     // 1 --> Optional(1)
    ///     // a --> Optional(10)
    ///     // Ｆ --> Optional(15)
    ///     // g --> nil
    var hexDigitValue: Int? {
        return hexValues.firstIndex(of: self.lowercased())
    }
    
    /// A Boolean value indicating whether this character represents a
    /// hexadecimal digit.
    ///
    /// Hexadecimal digits include 0-9, Latin letters a-f and A-F, and their
    /// fullwidth compatibility forms. To get the character's value, use the
    /// `hexDigitValue` property.
    var isHexDigit: Bool { return self.hexDigitValue != nil }
}

#endif
