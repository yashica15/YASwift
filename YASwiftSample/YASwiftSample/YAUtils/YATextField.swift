//
//  YATextField.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import UIKit
extension UITextField {
    
    // To restrict action like copy, paste
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        UIMenuController.shared.isMenuVisible = false
        return false
    }
    
    func addRightViewWithImage(image: UIImage?, rightViewMode: UITextField.ViewMode) {
        self.rightView?.isHidden = false
        self.rightViewMode = rightViewMode
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height + 10, height: self.frame.height))
        if let img = image {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height))
            imageView.contentMode = .left
            imageView.center = bgView.center
            imageView.image = img
            bgView.addSubview(imageView)
        }
        self.rightView = bgView
    }
    
    func addLeftView(padding: CGFloat) {
        self.leftViewMode = .always
        let bgView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
        self.leftView = bgView
    }
    
}
