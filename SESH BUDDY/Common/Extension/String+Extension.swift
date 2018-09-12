//
//  String+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 26/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

extension String {
  var stringByRemovingWhitespaces: String {
    return components(separatedBy: .whitespaces).joined()
  }
//    var localized: String {
//        if let path = Bundle.main.path(forResource: L102Language.currentAppleLanguage(), ofType: "lproj") {
//            if let bundle = Bundle(path: path) {
//                return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
//            }
//        }
//
//        return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
//    }
  
    func colorWithHexString () -> UIColor {
        let hex = self.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        return  UIColor.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
  var localized: String {
    if let path = Bundle.main.path(forResource: L102Language.currentAppleLanguage(), ofType: "lproj") {
      if let bundle = Bundle(path: path) {
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
      }
    } else {
      if let path = Bundle.main.path(forResource: "Base", ofType: "lproj") {
        if let bundle = Bundle(path: path) {
          return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: "", comment: "")
        }
      }
    }

    return NSLocalizedString(self, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
  }
    
//    func hmac(key: String) -> String {
//        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
//        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA1), key, key.count, self, self.count, &digest)
//        let data = Data(bytes: digest)
//        return data.map { String(format: "%02hhx", $0) }.joined()
//    }
    func trimeString() -> String {
         let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString
    }
    
    func removeNewLineAndBlankSpace()-> String {
        var trimStr = self.replacingOccurrences(of: " ", with: "")
        trimStr = trimStr.replacingOccurrences(of: "\n", with: "")
        return trimStr
    }
    
    // MARK: CONVERT DATE TIME
    func convertDateFormater( format: String = "MMM dd yyyy", utcToLocal: Bool = false, fromFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", localToutc: Bool = false ) -> Date {
        
        if self == "" {
            return Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = fromFormat
        
        dateFormatter.locale = NSLocale(localeIdentifier: "en-US") as Locale!
        if localToutc {
            dateFormatter.timeZone = NSTimeZone.local
        } else if utcToLocal {
            dateFormatter.timeZone = NSTimeZone(name: "IST") as TimeZone!
        } else {
            // dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            // dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        }
        
        let dateTime = dateFormatter.date(from: self)
        let formatter = DateFormatter()
        
        formatter.locale = NSLocale.current
        
        formatter.locale = NSLocale(localeIdentifier: "en-US") as Locale!
        if localToutc {
            formatter.timeZone = NSTimeZone(name: "IST") as TimeZone!
        } else if utcToLocal {
            dateFormatter.timeZone = NSTimeZone.local
        } else {
            // formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            // formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        }
        
        formatter.dateFormat = format
        var dateString = ""
        if dateTime != nil {
            dateString = formatter.string(from: dateTime!)
            return dateTime!
        } else {
            dateString = ""
            return Date()
        }
        
        
    }
  
  func getFormattedLocalDate(_ actualformat: String, requiredFormat: String, Locale: Locale? = nil) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = actualformat
    let dateFormed = dateFormatter.date(from: self)
    
    if let applyLocale = Locale {
      dateFormatter.locale = applyLocale
    }
    
    if dateFormed != nil {
      dateFormatter.dateFormat = requiredFormat
      return dateFormatter.string(from: dateFormed!)
    } else {
      return ""
    }
  }
  
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
  
    var html2AttributedString: NSAttributedString? {
      return Data(utf8).html2AttributedString
    }
    var html2String: String {
      return html2AttributedString?.string ?? ""
    }
  
  
}

//
//  NSAttributedString+Extensions.swift
//
//  Created by Ben Kreeger on 12/11/15.
//
// The MIT License (MIT)
//
// Copyright (c) 2014-2016 Oven Bits, LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

extension NSAttributedString {
  /**
   Returns a new mutable string with characters from a given character set removed.
   See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
   - Parameters:
   - charSet: The character set with which to remove characters.
   - returns: A new string with the matching characters removed.
   */
  public func trimmingCharacters(in set: CharacterSet) -> NSAttributedString {
    let modString = NSMutableAttributedString(attributedString: self)
    modString.trimCharacters(in: set)
    return NSAttributedString(attributedString: modString)
  }
}


extension NSMutableAttributedString {
  /**
   Modifies this instance of the string to remove characters from a given character set from
   the beginning and end of the string.
   See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
   - Parameters:
   - charSet: The character set with which to remove characters.
   */
  public func trimCharacters(in set: CharacterSet) {
    var range = (string as NSString).rangeOfCharacter(from: set)
    
    // Trim leading characters from character set.
    while range.length != 0 && range.location == 0 {
      replaceCharacters(in: range, with: "")
      range = (string as NSString).rangeOfCharacter(from: set)
    }
    
    // Trim trailing characters from character set.
    range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
    while range.length != 0 && NSMaxRange(range) == length {
      replaceCharacters(in: range, with: "")
      range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
    }
  }
  
}


extension NSMutableAttributedString {
  
  fileprivate var range: NSRange {
    return NSRange(location: 0, length: length)
  }
  
  fileprivate var paragraphStyle: NSMutableParagraphStyle? {
    return attributes(at: 0, effectiveRange: nil)[NSAttributedStringKey.paragraphStyle] as? NSMutableParagraphStyle
  }
  
}

// MARK: - Font
extension NSMutableAttributedString {
  /**
   Applies a font to the entire string.
   
   - parameter font: The font.
   */
  @discardableResult
  public func font(_ font: UIFont) -> Self {
    addAttribute(NSAttributedStringKey.font, value: font, range: range)
    return self
  }
  
  /**
   Applies a font to the entire string.
   
   - parameter name: The font name.
   - parameter size: The font size.
   
   Note: If the specified font name cannot be loaded, this method will fallback to the system font at the specified size.
   */
  @discardableResult
  public func font(name: String, size: CGFloat) -> Self {
    addAttribute(NSAttributedStringKey.font, value: UIFont(name: name, size: size) ?? .systemFont(ofSize: size), range: range)
    return self
  }
}

// MARK: - Paragraph style
extension NSMutableAttributedString {
  
  /**
   Applies a text alignment to the entire string.
   
   - parameter alignment: The text alignment.
   */
  @discardableResult
  public func alignment(_ alignment: NSTextAlignment) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies line spacing to the entire string.
   
   - parameter lineSpacing: The line spacing amount.
   */
  @discardableResult
  public func lineSpacing(_ lineSpacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies paragraph spacing to the entire string.
   
   - parameter paragraphSpacing: The paragraph spacing amount.
   */
  @discardableResult
  public func paragraphSpacing(_ paragraphSpacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacing = paragraphSpacing
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a line break mode to the entire string.
   
   - parameter mode: The line break mode.
   */
  @discardableResult
  public func lineBreak(_ mode: NSLineBreakMode) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = mode
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a line height multiplier to the entire string.
   
   - parameter multiple: The line height multiplier.
   */
  @discardableResult
  public func lineHeight(multiple: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = multiple
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a first line head indent to the string.
   
   - parameter indent: The first line head indent amount.
   */
  @discardableResult
  public func firstLineHeadIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.firstLineHeadIndent = indent
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a head indent to the string.
   
   - parameter indent: The head indent amount.
   */
  @discardableResult
  public func headIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.headIndent = indent
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a tail indent to the string.
   
   - parameter indent: The tail indent amount.
   */
  @discardableResult
  public func tailIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.tailIndent = indent
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a minimum line height to the entire string.
   
   - parameter height: The minimum line height.
   */
  @discardableResult
  public func minimumLineHeight(_ height: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = height
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a maximum line height to the entire string.
   
   - parameter height: The maximum line height.
   */
  @discardableResult
  public func maximumLineHeight(_ height: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = height
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a base writing direction to the entire string.
   
   - parameter direction: The base writing direction.
   */
  @discardableResult
  public func baseWritingDirection(_ direction: NSWritingDirection) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.baseWritingDirection = direction
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a paragraph spacing before amount to the string.
   
   - parameter spacing: The distance between the paragraph’s top and the beginning of its text content.
   */
  @discardableResult
  public func paragraphSpacingBefore(_ spacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacingBefore = spacing
    
    addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
}

// MARK: - Foreground color
extension NSMutableAttributedString {
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func color(_ color: UIColor, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.foregroundColor, value: color.withAlphaComponent(alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult
  public func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(red: red, green: green, blue: blue, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult
  public func color(white: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(white: white, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func color(_ hex: UInt32, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor(white: CGFloat(hex), alpha: alpha), range: range)
    return self
  }
}

// MARK: - Underline, kern, strikethrough, stroke, shadow, text effect
extension NSMutableAttributedString {
  /**
   Applies a single underline under the entire string.
   
   - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
   */
  @discardableResult
  public func underline(style: NSUnderlineStyle = .styleSingle, color: UIColor? = nil) -> Self {
    addAttribute(NSAttributedStringKey.underlineStyle, value: style.rawValue, range: range)
    
    if let color = color {
      addAttribute(NSAttributedStringKey.underlineColor, value: color, range: range)
    }
    
    return self
  }
  
  /**
   Applies a kern (spacing) value to the entire string.
   
   - parameter value: The space between each character in the string.
   */
  @discardableResult
  public func kern(_ value: CGFloat) -> Self {
    addAttribute(NSAttributedStringKey.kern, value: value, range: range)
    return self
  }
  
  /**
   Applies a strikethrough to the entire string.
   
   - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
   - parameter color: The underline color. Defaults to the color of the text.
   */
  @discardableResult
  public func strikethrough(style: NSUnderlineStyle = .styleSingle, color: UIColor? = nil) -> Self {
    addAttribute(NSAttributedStringKey.strikethroughStyle, value: style.rawValue, range: range)
    
    if let color = color {
      addAttribute(NSAttributedStringKey.strikethroughColor, value: color, range: range)
    }
    
    return self
  }
  
  /**
   Applies a stroke to the entire string.
   
   - parameter color: The stroke color.
   - parameter width: The stroke width.
   */
  @discardableResult
  public func stroke(color: UIColor, width: CGFloat) -> Self {
    addAttributes([
      NSAttributedStringKey.strokeColor : color,
      NSAttributedStringKey.strokeWidth : width
      ], range: range)
    
    return self
  }
  
  /**
   Applies a shadow to the entire string.
   
   - parameter color: The shadow color.
   - parameter radius: The shadow blur radius.
   - parameter offset: The shadow offset.
   */
  @discardableResult
  public func shadow(color: UIColor, radius: CGFloat, offset: CGSize) -> Self {
    let shadow = NSShadow()
    shadow.shadowColor = color
    shadow.shadowBlurRadius = radius
    shadow.shadowOffset = offset
    
    addAttribute(NSAttributedStringKey.shadow, value: shadow, range: range)
    
    return self
  }
  
}

// MARK: - Background color
extension NSMutableAttributedString {
  
  /**
   Applies a background color to the entire string.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func backgroundColor(_ color: UIColor, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.backgroundColor, value: color.withAlphaComponent(alpha) , range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter red: The red color component.
   - parameter green: The green color component.
   - parameter blue: The blue color component.
   - parameter alpha: The alpha component.
   */
  @discardableResult
  public func backgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor(red: red, green: green, blue: blue, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter white: The white color component.
   - parameter alpha: The alpha component.
   */
  @discardableResult
  public func backgroundColor(white: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor(white: white, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter hex: The hex color value.
   - parameter alpha: The alpha component.
   */
  @discardableResult @nonobjc
  public func backgroundColor(_ hex: UInt32, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor(white: CGFloat(hex), alpha: alpha), range: range)
    return self
  }
}

extension NSMutableAttributedString {
  
  /**
   Applies a baseline offset to the entire string.
   
   - parameter offset: The offset value.
   */
  @discardableResult
  public func baselineOffset(_ offset: Float) -> Self {
    addAttribute(NSAttributedStringKey.baselineOffset, value: NSNumber(value: offset), range: range)
    return self
  }
}

public func +(lhs: NSMutableAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
  let lhs = NSMutableAttributedString(attributedString: lhs)
  lhs.append(rhs)
  return lhs
}

public func +=(lhs: NSMutableAttributedString, rhs: NSAttributedString) {
  lhs.append(rhs)
}

