//
//  YATextField.swift
//  Yashica Agrawal
//
//  Created by Yashica Agrawal on 1/13/16.
//  Copyright © 2016 Yashica Agrawal. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    
    // To restrict action like copy, paste
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }
}
