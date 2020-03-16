//
//  YAPickerViewInputVC.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import CocoaLumberjack
import IQDropDownTextField
import UIDropDown

class YAPickerViewInputVC: UIViewController, IQDropDownTextFieldDelegate, IQDropDownTextFieldDataSource {

    @IBOutlet weak var lblSelectValues: UILabel!
    @IBOutlet weak var viewSelectCountry: UIDropDown!
    @IBOutlet weak var txtSelectCity: IQDropDownTextField!
    @IBOutlet weak var txtSelectZipcode: IQDropDownTextField!
    @IBOutlet weak var txtSelectDate: IQDropDownTextField!
    @IBOutlet weak var txtSelectTime: IQDropDownTextField!
    @IBOutlet weak var txtSelectDateTime: IQDropDownTextField!
    @IBOutlet weak var btnShow: UIButton!

    var arrPickerCountry:[String] = ["India", "Mexico", "USA", "England", "France", "Germany", "Spain", "Italy", "Canada"]
    var arrPickerCity:[String] = ["Indore","Bhopal","Gwalior","Jabalpur"]
    var arrPickerZip:[String] = ["452001","452023","452015","452005","452089","452010","452078"]
    var arrPicker = [String]()

    //MARK: Viewlife Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Picker TextField"
    
        self.dropdownViewSetting()
        
        self.textFieldPickerSetting()
    }
    
    //MARK: Dropdown Setting
    func dropdownViewSetting() -> Void {
        self.viewSelectCountry.tint = colorThemeDarkest
        self.viewSelectCountry.arrowPadding = 10.0
        self.viewSelectCountry.placeholder = "Select country"
        self.viewSelectCountry.options = arrPickerCountry
        self.viewSelectCountry.animationType = .Classic
        self.viewSelectCountry.borderColor = colorThemeLight
        self.viewSelectCountry.borderWidth = 1.0
        self.viewSelectCountry.cornerRadius = 5.0
        self.viewSelectCountry.fontSize = 15.0
        self.viewSelectCountry.textColor = colorThemeDarkest
        self.viewSelectCountry.textAlignment = .center
        
        self.viewSelectCountry.tableHeight = 200.0
        self.viewSelectCountry.rowHeight = kSCREEN_HEIGHT*0.05
        
//        self.viewSelectCountry.optionsBorderColor = colorThemeLight
//        self.viewSelectCountry.optionsBorderWidth = 1.0
//        self.viewSelectCountry.optionsCornerRadius = 5.0
        self.viewSelectCountry.optionsSize = 15.0
        self.viewSelectCountry.optionsTextColor = colorThemeDarkest
        self.viewSelectCountry.hideOptionsWhenSelect = true
        self.viewSelectCountry.didSelect { (option, index) in
            print("You just select: \(option) at index: \(index)")
            self.viewSelectCountry.addBorder(color: colorThemeLight, borderWidth: 1.0)
        }
    }
    
    //MARK: Textfield Setting
    func textFieldPickerSetting() -> Void {
        self.txtSelectCity.addBorderAndRoundedCorner(color: colorThemeLight, borderWidth: 1.0, cornerRadius: 5.0)
        self.txtSelectZipcode.addBorderAndRoundedCorner(color: colorThemeLight, borderWidth: 1.0, cornerRadius: 5.0)
        self.txtSelectDate.addBorderAndRoundedCorner(color: colorThemeLight, borderWidth: 1.0, cornerRadius: 5.0)
        self.txtSelectTime.addBorderAndRoundedCorner(color: colorThemeLight, borderWidth: 1.0, cornerRadius: 5.0)
        self.txtSelectDateTime.addBorderAndRoundedCorner(color: colorThemeLight, borderWidth: 1.0, cornerRadius: 5.0)
        
        let formatter: DateFormatter = DateFormatter.init()
        formatter.dateFormat = "EEE MMMM dd yyyy"
        self.txtSelectDate.dateFormatter = formatter
        self.txtSelectDate.dropDownMode = .datePicker
        self.txtSelectTime.dropDownMode = .timePicker
        self.txtSelectDateTime.dropDownMode = .dateTimePicker
        
        self.txtSelectCity.isOptionalDropDown = false
        self.txtSelectCity.itemList = arrPickerCity
    
        self.txtSelectZipcode.isOptionalDropDown = true
        self.txtSelectZipcode.itemList = arrPickerZip
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = colorThemeLight
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClicked))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelClicked))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.txtSelectCity.inputAccessoryView = toolBar
        self.txtSelectZipcode.inputAccessoryView = toolBar
        self.txtSelectDate.inputAccessoryView = toolBar
        self.txtSelectTime.inputAccessoryView = toolBar
        self.txtSelectDateTime.inputAccessoryView = toolBar

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IQDropdownTextField Delegate
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        print("\(NSStringFromSelector(#function)): \(String(describing: item))")
        textField.addBorder(color: colorThemeLight, borderWidth: 1.0)
    }
    
    func textField(_ textField: IQDropDownTextField, didSelect date: Date?) {
        print("\(NSStringFromSelector(#function)): \(String(describing: date))")
    }
    
    func textField(_ textField: IQDropDownTextField, canSelectItem item: String) -> Bool {
        print("\(NSStringFromSelector(#function)): \(String(describing: item))")
        return true
    }
    
    func textField(_ textField: IQDropDownTextField, proposedSelectionModeForItem item: String) -> IQProposedSelection {
        print("\(NSStringFromSelector(#function)): \(String(describing: item))")
        return .both
    }
    
    //MARK: UITextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("\(NSStringFromSelector(#function))")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(NSStringFromSelector(#function))")
    }
    
    @objc func cancelClicked(button: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    @objc func doneClicked(button: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    //MARK: UIButton Click Methods
    @IBAction func btnShow_Clicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        var isValid:Bool = true
        
        DDLogDebug("Selected dropdown \(self.viewSelectCountry.selectedIndex ?? -1)")
        
        let intSelectCountry:Int = self.viewSelectCountry.selectedIndex ?? -1
        
        if intSelectCountry < 0 {
            isValid = false
            self.viewSelectCountry.addBorder(color: colorRed, borderWidth: 1.0)
        }
        
        if (self.txtSelectCity.selectedRow < 0) {
            isValid = false
            self.txtSelectCity.addBorder(color: colorRed, borderWidth: 1.0)
//            if (txtSelectZipcode.selectedRow < 0) {
//                txtSelectZipcode.addBorder(color: colorRed, borderWidth: 1.0)
//            }
//        } else if (txtSelectZipcode.selectedRow < 0) {
//            txtSelectZipcode.addBorder(color: colorRed, borderWidth: 1.0)
        }
        
        if (self.txtSelectDate.selectedItem?.isEmpty)! {
            isValid = false
            self.txtSelectDate.addBorder(color: colorRed, borderWidth: 1.0)
        }
        
        if (self.txtSelectTime.selectedItem?.isEmpty)! {
            isValid = false
            self.txtSelectTime.addBorder(color: colorRed, borderWidth: 1.0)
        }

        if (self.txtSelectDateTime.selectedItem?.isEmpty)! {
            isValid = false
            self.txtSelectDateTime.addBorder(color: colorRed, borderWidth: 1.0)
        }
        
        if isValid {
            let alert = UIAlertController(title: "Info you have selected:", message: "\nCountry: \(self.arrPickerCountry[self.viewSelectCountry.selectedIndex!]) \nCity: \(self.txtSelectCity.selectedItem ?? "") \nZipcode: \(self.txtSelectZipcode.selectedItem ?? "") \nDate: \(self.txtSelectDate.selectedItem ?? "") \nTime: \(self.txtSelectTime.selectedItem ?? "") \nDateTime: \(self.txtSelectDateTime.selectedItem ?? "")",
                preferredStyle: UIAlertController.Style.alert)
            alert.view.tintColor = colorThemeLight
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ (ACTION :UIAlertAction!)in
                DDLogDebug("User click Ok button")
//                self.txtSelectCity.selectedRow = 0
//                self.txtSelectZipcode.selectedRow = -1
            }))
            self.present(alert, animated: true, completion: { 
                alert.view.tintColor = colorThemeLight
            })
        }
    }
}
