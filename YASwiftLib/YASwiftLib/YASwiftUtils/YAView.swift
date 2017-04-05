//
//  YAView.swift
//  Yashica Agrawal
//
//  Created by Yashica Agrawal on 03/04/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addBorderAndRoundedCorner(color:UIColor, borderWidth:CGFloat, cornerRadius:CGFloat) -> Void {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func addBorder(color:UIColor, borderWidth:CGFloat?) -> Void {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth ?? 1.0
        self.layer.masksToBounds = true
    }

    func addRoundedCorner(cornerRadius:CGFloat) -> Void {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
}
