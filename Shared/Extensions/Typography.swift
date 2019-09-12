//
//  Typography.swift
//  Moneywell
//
//  Created by Abram Situmorang on 09/09/19.
//  Copyright © 2019 Abram Situmorang. All rights reserved.
//

import Foundation
import UIKit

public class AirbnbCereal {
    public enum Weight {
        case bold
        case extraBold
        case book
        case medium
        case light
    }
    
    internal static func font(_ weight: Weight) -> UIFont {
        switch weight {
        case .bold: return self.bold
        case .extraBold: return self.extraBold
        case .book: return self.book
        case .medium: return self.medium
        case .light: return self.light
        }
    }
    
    internal static var bold: UIFont {
        return UIFont(name: "AirbnbCereal-Bold", size: 1) ?? UIFont.systemFont(ofSize: 1, weight: .bold)
    }
    
    internal static var extraBold: UIFont {
        return UIFont(name: "AirbnbCereal-ExtraBold", size: 1) ?? UIFont.systemFont(ofSize: 1, weight: .heavy)
    }
    
    internal static var book: UIFont {
        return UIFont(name: "AirbnbCereal-Book", size: 1) ?? UIFont.systemFont(ofSize: 1, weight: .regular)
    }
    
    internal static var medium: UIFont {
        return UIFont(name: "AirbnbCereal-Medium", size: 1) ?? UIFont.systemFont(ofSize: 1, weight: .medium)
    }
    
    internal static var light: UIFont {
        return UIFont(name: "AirbnbCereal-Light", size: 1) ?? UIFont.systemFont(ofSize: 1, weight: .light)
    }
}

extension NSAttributedString {
    internal class func setFont(font: UIFont, kerning: Double = 0, color: UIColor, lineSpacing: CGFloat? = nil, alignment: NSTextAlignment, strikethrough: Bool) -> [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        paragraphStyle.alignment = alignment
        
        var attribute = [.font: font,
                         .kern: kerning,
                         .foregroundColor: color,
                         .paragraphStyle: paragraphStyle] as [NSAttributedString.Key: Any]
        
        if strikethrough {
            attribute[.strikethroughStyle] = NSUnderlineStyle.single.rawValue
        }
        return attribute
    }
    
    public class func text(_ string: String, size: CGFloat, weight: AirbnbCereal.Weight = .medium, color: UIColor = .black, alignment: NSTextAlignment = .left, strikethrough: Bool = false) -> NSAttributedString {
        
        
        let attribute = NSAttributedString.setFont(
            font: AirbnbCereal.font(weight).withSize(size),
            kerning: -0.3,
            color: color,
            lineSpacing: -4,
            alignment: alignment,
            strikethrough: strikethrough
        )
        let attributeString = NSMutableAttributedString(string: string, attributes: attribute)
        return attributeString
    }
}
