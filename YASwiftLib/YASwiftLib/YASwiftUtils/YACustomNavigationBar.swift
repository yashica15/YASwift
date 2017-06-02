//
//  YACustomNavigationBar.swift
//  YASwiftLib
//
//  Created by Yashica Agrawal on 05/04/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit

let kInsetBottom:CGFloat = -10.0

class YACustomNavigationBar: UINavigationBar {

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var navigationBarSize = super.sizeThatFits(size);
        if kIS_IPAD {
            // Pad the base navigation bar height by the fitting height of our button.
            navigationBarSize.height += navigationBarSize.height
        }
        return navigationBarSize;
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let navigationBarAppearance = UINavigationBar.appearance()
        let barButtonItemAppearance = UIBarButtonItem.appearance()
        
        navigationBarAppearance.barTintColor = colorLavender
        navigationBarAppearance.tintColor = colorEggplant
        
        if kIS_IPAD {
            let insets:UIEdgeInsets = UIEdgeInsetsMake(0, 0, kInsetBottom, 0)
            let imgBackArrow:UIImage = (UIImage(named: "back")?.withAlignmentRectInsets(insets))!
            
            navigationBarAppearance.backIndicatorImage = imgBackArrow
            navigationBarAppearance.backIndicatorTransitionMaskImage = imgBackArrow
            
            barButtonItemAppearance.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, kInsetBottom), for: .default)

            // change navigation item title color
            navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:colorEggplant, NSFontAttributeName:UIFont.YALightSystemFont(ofSize: 36.0)]
            
            navigationBarAppearance.setTitleVerticalPositionAdjustment(kInsetBottom, for: .default)
            
            let navigationItem = self.topItem
            for subview in self.subviews {
                
                if subview == navigationItem?.leftBarButtonItem?.customView {
                    let newLeftButtonFrame:CGRect = CGRect(x: subview.frame.origin.x, y: subview.frame.origin.y-kInsetBottom, width: subview.frame.size.width
                        , height: subview.frame.size.width)
                    subview.frame = newLeftButtonFrame
                }
            }
            
        } else {
            // change navigation item title color
            navigationBarAppearance.titleTextAttributes = [NSForegroundColorAttributeName:colorEggplant, NSFontAttributeName:UIFont.YALightSystemFont(ofSize: 24.0)]
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}