//
//  YAPickerViewInputVC.swift
//  YASwiftLib
//
//  Created by Yashica Agrawal on 03/04/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit

class YAPickerViewInputVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var lblSelectValues: UILabel!
    @IBOutlet weak var txtSelectCity: UITextField!
    @IBOutlet weak var txtSelectZipcode: UITextField!
    @IBOutlet weak var btnShow: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var arrPickerCity = ["Indore","Bhopal","Gwalior","Jabalpur"]
    var arrPickerZip = ["452001","452023","452015","452005","452089","452010","452078"]
    var arrPicker = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Picker TextField"
        
        pickerView.isHidden = true
        txtSelectCity.inputView = pickerView
        txtSelectCity.addBorderAndRoundedCorner(color: colorGrape, borderWidth: 1.0, cornerRadius: 5.0)
        
        txtSelectZipcode.inputView = pickerView
        txtSelectZipcode.addBorderAndRoundedCorner(color: colorGrape, borderWidth: 1.0, cornerRadius: 5.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: PickerView Datasource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrPicker[row]
    }
    
    //MARK: PickerView Delegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView.tag == 0) {
            txtSelectCity.text = arrPicker[row]
            txtSelectCity.addBorder(color: colorGrape, borderWidth: 1.0)
        } else {
            txtSelectZipcode.text = arrPicker[row]
            txtSelectZipcode.addBorder(color: colorGrape, borderWidth: 1.0)
        }
        
        pickerView.isHidden = true
    }
    
    //MARK: textFielf Delegate
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        arrPicker.removeAll()
        if (textField == txtSelectCity) {
            arrPicker = arrPickerCity
            pickerView.tag = 0
        } else {
            arrPicker = arrPickerZip
            pickerView.tag = 1
        }
        pickerView.isHidden = false
        pickerView .reloadAllComponents()
        return false
    }

    @IBAction func btnShow_Clicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        txtSelectCity.resignFirstResponder()
        txtSelectZipcode.resignFirstResponder()
        
        if (txtSelectCity.text?.isEmpty)! {
            txtSelectCity.addBorder(color: colorRed, borderWidth: 1.0)
            if (txtSelectZipcode.text?.isEmpty)!   {
                txtSelectZipcode.addBorder(color: colorRed, borderWidth: 1.0)
            }
        } else if (txtSelectZipcode.text?.isEmpty)!   {
            txtSelectZipcode.addBorder(color: colorRed, borderWidth: 1.0)
        } else {
            let alert = UIAlertController(title: "Alert", message: "You have selected \(txtSelectCity.text ?? "") and \(txtSelectZipcode.text ?? "")", preferredStyle: UIAlertControllerStyle.alert)
            alert.view.tintColor = colorGrape

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (ACTION :UIAlertAction!)in
                print("User click Ok button")
                
                self.txtSelectCity.text = ""
                self.txtSelectZipcode.text = ""
            }))
            self.present(alert, animated: true, completion: { 
                alert.view.tintColor = colorGrape
            })
        }
    }
}
