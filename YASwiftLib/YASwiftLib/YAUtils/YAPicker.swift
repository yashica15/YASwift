//
//  Picker.swift
//  Yashica Agrawal
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

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
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



@objc protocol customPickerDelegate {
    
    @objc optional func doneFromPicker(_ textField:UITextField,indexData:Int)
    @objc optional func insertData(_ textField:UITextField,indexData:Int) -> String
}

class Picker: UIPickerView ,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var delegatePicker:customPickerDelegate?
    
    @IBInspectable   var arrData : NSArray?
    @IBInspectable  internal var tfInputField : UITextField?
    let toolbar = UIToolbar()
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.delegate=self
        self.dataSource=self
        self.reloadAllComponents()
        
        toolbar.frame = CGRect(x: 0, y: -44, width: self.frame.size.width, height: 44)
        toolbar.sizeToFit()
        let cancelButton=UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Picker.onTap_Cancel))
        let doneButton=UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(Picker.onTap_Done(_:)))
        let flexibleSpace=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace , target: nil, action: nil)
        toolbar.setItems([cancelButton,flexibleSpace,doneButton], animated: true)
        self.superview?.addSubview(toolbar)
        let nameArrayLength = arrData!.count
        
        for indexs in 0..<nameArrayLength {
            print(index)
            if let strDta:NSString  = arrData?.object(at: indexs) as? NSString {
                if  tfInputField?.text ==  strDta as String{
                    self.selectRow(indexs, inComponent: 0, animated: true)
                }
            }else{
                if  tfInputField?.text ==  delegatePicker?.insertData!(tfInputField!,indexData:indexs){
                    self.selectRow(indexs, inComponent: 0, animated: true)
                }
            }
        }
        
   //  canPerformAction("paste:" as Selector, withSender: tfInputField)
   //     tfInputField?.delegate=self
    }
    
    func setdata(_ arrDataInput:NSArray,tfInput:UITextField){
        self.reloadAllComponents()
        arrData=arrDataInput
        tfInputField = tfInput
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (arrData?.count)!;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        arrData?.object(at: row)
        if let strDta:NSString  = arrData?.object(at: row) as? NSString {
            
            return strDta as String
            
        }else{
            let strObjectToInsert = (delegatePicker?.insertData!(tfInputField!,indexData: row))! as String
            if strObjectToInsert == tfInputField!.text{
                self.selectRow(row, inComponent: 0, animated: false)
            }
            return  strObjectToInsert
        }
        
    }
    
    
    func onTap_Cancel() {
        print("Cancel")
        tfInputField?.resignFirstResponder()
        toolbar.removeFromSuperview();
    }
    
    
    func onTap_Done(_ sender: UIBarButtonItem) {
        print("Done")
        if arrData?.count>0 {
        if let strDta:NSString  = arrData?.object(at: self.selectedRow(inComponent: 0)) as? NSString {
            tfInputField?.text =  strDta as String
        }else{
            tfInputField?.text =   delegatePicker?.insertData!(tfInputField!,indexData: self.selectedRow(inComponent: 0))
        }
        
        tfInputField?.resignFirstResponder()
        toolbar.removeFromSuperview();
            delegatePicker?.doneFromPicker!(tfInputField!,indexData: self.selectedRow(inComponent: 0))
        }
    }
    
    
    // MARK: - UITableViewDataSource
    func removeAllViews(){
        tfInputField?.resignFirstResponder()
        toolbar.removeFromSuperview();
    }
}
