//
//  YAConstant.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}


#if DEBUG
    let kDEBUG_MODE = true
    let kSERVER_BASE_URL  = "google.com"
#else
    let kDEBUG_MODE = false
#endif

// UUID 
let kUUID = Utility().deviceUUID()

// IPHONE SCREEN WIDTH AND HEIGHT BOUND CONDITION
let kIS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
let kIS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let kIS_RETINA = UIScreen.main.scale >= 2.0
let kSYSTEM_VERSION = Float(UIDevice.current.systemVersion)

let kSCREEN_X = UIScreen.main.bounds.origin.x
let kSCREEN_Y = UIScreen.main.bounds.origin.y
let kSCREEN_WIDTH = UIScreen.main.bounds.size.width
let kSCREEN_HEIGHT = UIScreen.main.bounds.size.height

let kSCREEN_MAX_LENGTH = max(kSCREEN_WIDTH, kSCREEN_HEIGHT)
let kSCREEN_MIN_LENGTH = min(kSCREEN_WIDTH, kSCREEN_HEIGHT)

let kIS_IPHONE_4_OR_LESS = (kIS_IPHONE && kSCREEN_MAX_LENGTH < 568.0)
let kIS_IPHONE_5 = (kIS_IPHONE && kSCREEN_MAX_LENGTH == 568.0)
let kIS_IPHONE_5_OR_LESS    = (kIS_IPHONE_4_OR_LESS || kIS_IPHONE_5)
let kIS_IPHONE_6 = (kIS_IPHONE && kSCREEN_MAX_LENGTH == 667.0)
let kIS_IPHONE_6P = (kIS_IPHONE && kSCREEN_MAX_LENGTH == 736.0)

// IOS version check
let kIS_OS_7 = ((kSYSTEM_VERSION >= 7.0) && (kSYSTEM_VERSION < 8.0))
let kIS_OS_7_OR_LATER = ((kSYSTEM_VERSION >= 7.0))
let kIS_OS_8_OR_LATER = (kSYSTEM_VERSION >= 8.0)

let kRATIO_WIDTH_4 = 0.85
let kRATIO_HEIGHT_4 = 0.72
let kRATIO_5 = 0.85
let kRATIO_6 = 1.0
let kRATIO_6_PLUS = 1.10

//for Padding
let padding: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 40))

// Common Color Code
let colorClear = UIColor.clear
let colorWhite = UIColor.white
let colorBlack = UIColor.black
let colorRed = UIColor.red
let colorGray = UIColor.gray
let colorDarkGray = UIColor.darkGray
let colorLightGray = UIColor.lightGray
let colorYellow = UIColor.yellow
let colorGreen = UIColor.green
let colorCyan = UIColor.cyan

let colorThemeDarkest = UIColor.systemBlue
let colorThemeDark = UIColor.systemBlue.withAlphaComponent(0.75)
let colorThemeLight = UIColor.systemBlue.withAlphaComponent(0.5)
let colorThemeLightest = UIColor.systemBlue.withAlphaComponent(0.25)

// Constant Images
let imageLogo       = UIImage(named: "iTunesArtwork")
let imageIconBack   = UIImage(named: "icon_back")
let imageLogoPlaceholder    = UIImage(named: "placeholder")

// TextField left padding frame.
let textPaddingFrame = CGRect(x: 0, y: 0, width: 10, height: 10)


//MARK: Pagination Constant
let kPageIndex  = 0
let kPageSize   = 50
