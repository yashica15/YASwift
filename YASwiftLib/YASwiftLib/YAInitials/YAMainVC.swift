//
//  YAMainVC.swift
//  YASwiftLib
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import SideMenu

class YAMainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Main View"
        
        // Side Menu Bar Presentation settings
        // For more detail visit reference: https://github.com/jonkykong/SideMenu
        setupSideMenu()
    }
    
    fileprivate func setupSideMenu() {
        // Define the menus
        SideMenuManager.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "YALeftMenuTVC") as? UISideMenuNavigationController

        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        SideMenuManager.menuPresentMode = .menuSlideIn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

