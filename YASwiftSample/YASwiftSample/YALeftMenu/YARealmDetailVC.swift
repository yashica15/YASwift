//
//  YARealmDetailVC.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import CocoaLumberjack

class YARealmDetailVC: UIViewController {

    var objPerson : Person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        DDLogDebug("objPerson: \(objPerson)")

        self.title = objPerson.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
