//
//  Fonts.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import UIKit

struct YAAppFontName {
    static let regular          = "Helvetica"
    static let italic           = "Helvetica-Italic"
    static let light            = "Helvetica-Light"
    static let lightItalic      = "Helvetica-LightItalic"
    static let semiBold         = "Helvetica-Semibold"
    static let semiBoldItalic   = "Helvetica-SemiboldItalic"
    static let bold             = "Helvetica-Bold"
    static let boldItalic       = "Helvetica-BoldItalic"
    static let extraBold        = "Helvetica-ExtraBold"
    static let extraBoldItalic  = "Helvetica-ExtraBoldItalic"
}

extension UIFont {
    
    @objc class func YASystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.regular, size: size)!
    }
    
    @objc class func YAItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.italic, size: size)!
    }

    class func YALightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.light, size: size)!
    }

    class func YALightItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.lightItalic, size: size)!
    }

    class func YASemiBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.semiBold, size: size)!
    }

    class func YASemiBoldItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.semiBoldItalic, size: size)!
    }
    
    @objc class func YABoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.bold, size: size)!
    }

    class func YABoldItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.boldItalic, size: size)!
    }

    class func YAExtraBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.extraBold, size: size)!
    }

    class func YAExtraBoldItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: YAAppFontName.extraBoldItalic, size: size)!
    }

    @objc convenience init(YACoder aDecoder: NSCoder) {
        if let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor {
            if let fontAttribute = fontDescriptor.fontAttributes[UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")] as? String {
                var fontName = ""
                switch fontAttribute {
                case "CTFontRegularUsage":
                    fontName = YAAppFontName.regular
                case "CTFontEmphasizedUsage", "CTFontBoldUsage":
                    fontName = YAAppFontName.bold
                case "CTFontObliqueUsage":
                    fontName = YAAppFontName.italic
                default:
                    fontName = YAAppFontName.regular
                }
                self.init(name: fontName, size: fontDescriptor.pointSize)!
            }
            else {
                self.init(YACoder: aDecoder)
            }
        }
        else {
            self.init(YACoder: aDecoder)
        }
    }
    
    class func overrideInitialize() {
        if self == UIFont.self {
            let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:)))
            let mySystemFontMethod = class_getClassMethod(self, #selector(YASystemFont(ofSize:)))
            method_exchangeImplementations(systemFontMethod!, mySystemFontMethod!)
            
            let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:)))
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(YABoldSystemFont(ofSize:)))
            method_exchangeImplementations(boldSystemFontMethod!, myBoldSystemFontMethod!)
            
            let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:)))
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(YAItalicSystemFont(ofSize:)))
            method_exchangeImplementations(italicSystemFontMethod!, myItalicSystemFontMethod!)
            
            let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))) // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(YACoder:)))
            method_exchangeImplementations(initCoderMethod!, myInitCoderMethod!)
        }
    }
}
