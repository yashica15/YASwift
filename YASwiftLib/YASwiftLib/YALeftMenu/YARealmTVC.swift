//
//  YARealmTVC.swift
//  YASwiftLib
//
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import RealmSwift
import CocoaLumberjack

class YARealmTVC: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var btnRightBarButtonAdd: UIBarButtonItem!
    
    var YADatePicker: UIDatePicker!
    var alertController: UIAlertController!
    var saveAction : UIAlertAction?
    var cancelAction : UIAlertAction?
    var arrPerson : Results<Person>?
    var dateFormatter :DateFormatter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.title = "Realm Sample"
        
        arrPerson = RLMManager().fetchPersonList()
        
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnRightBarButtonAdd_Clicked(_ sender: UIBarButtonItem) {
        self.addEditPerson(isEdit: false, objPerson: nil)
    }
    
    func addEditPerson(isEdit:Bool, objPerson:Person?) -> Void {
        var titleText = ""
        
        if isEdit {
            titleText = "Edit"
        } else {
            titleText = "Add New"
        }
        
        alertController = UIAlertController(title: titleText, message: "", preferredStyle: .alert)
        self.alertController.view.tintColor = colorGrape
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Name"
            textField.tag = 101
            textField.delegate = self
            textField.enablesReturnKeyAutomatically = true
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingChanged)
            
            if isEdit {
                textField.text = objPerson?.name
            }
        }
        
        YADatePicker = UIDatePicker()
        YADatePicker.datePickerMode = .date
        YADatePicker.maximumDate = Date()
        YADatePicker.addTarget(self, action: #selector(self.YADatePicker_ValueChanged(_:)), for: .valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = colorGrape
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Birthday"
            textField.inputView = self.YADatePicker
            textField.inputAccessoryView = toolBar
            textField.tag = 102
            textField.delegate = self
            textField.enablesReturnKeyAutomatically = true
            textField.addTarget(self, action: #selector(self.textChanged(_:)), for: .editingDidEnd)
            
            if isEdit {
                let birthDate = objPerson?.birthdate
                textField.text = self.dateFormatter.string(from: birthDate! as Date)
                self.YADatePicker.date = birthDate! as Date
            }
        }
        
        saveAction = UIAlertAction(title: "Save", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = self.alertController.textFields![0] as UITextField
            let secondTextField = self.alertController.textFields![1] as UITextField
            
            DDLogDebug("Name :\(firstTextField.text ?? ""), Birthday :\(secondTextField.text ?? "")")
            
            if isEdit {
                let isResult = RLMManager().updatePersonObject(objPerson: objPerson!, name: (firstTextField.text?.trimmedString())!, birthDate: self.YADatePicker.date as NSDate)
                
                if isResult == false {
                    YAAppDelegate.getDelegate().toastView(hudType: .YAShowToastMessage, strToastMessage: "There is some error in add. Please try later.")
                } else {
                    self.arrPerson = RLMManager().fetchPersonList()
                    self.tableView.reloadData()
                }
            } else {
                let objPerson = Person()
                objPerson.name = (firstTextField.text?.trimmedString())!
                objPerson.birthdate = self.YADatePicker.date as NSDate
                
                let isResult = RLMManager().savePersonObject(objPerson: objPerson)
                if isResult == false {
                    YAAppDelegate.getDelegate().toastView(hudType: .YAShowToastMessage, strToastMessage: "There is some error in add. Please try later.")
                } else {
                    self.arrPerson = RLMManager().fetchPersonList()
                    self.tableView.reloadData()
                }
            }
        })
        
        cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addAction(saveAction!)
        alertController.addAction(cancelAction!)
        saveAction?.isEnabled = false
        
        self.present(alertController, animated: true, completion: {
            self.alertController.view.tintColor = colorGrape
        })
    }
    
    @objc func textChanged(_ sender:UITextField) {
        let firstTextField = self.alertController.textFields![0] as UITextField
        let secondTextField = self.alertController.textFields![1] as UITextField

        if let text1 = firstTextField.text, let text2 = secondTextField.text {
            self.saveAction?.isEnabled = !text1.isEmpty && !text2.isEmpty
        }
    }

    @objc func YADatePicker_ValueChanged(_ sender: UIDatePicker) {
        let secondTextField = self.alertController.textFields![1] as UITextField
        secondTextField.text = dateFormatter.string(from: sender.date)
    }

    @objc func donePicker() {
        let secondTextField = self.alertController.textFields![1] as UITextField
        secondTextField.text = dateFormatter.string(from: YADatePicker.date)
        secondTextField.resignFirstResponder()
    }

    @objc func cancelPicker() {
        let secondTextField = self.alertController.textFields![1] as UITextField
        secondTextField.resignFirstResponder()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPerson!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YARealmCell", for: indexPath)

        // Configure the cell...
        let objPerson:Person = self.arrPerson![indexPath.row]
        
        cell.textLabel?.text = objPerson.name.capitalized
        cell.detailTextLabel?.text = dateFormatter.string(from: objPerson.birthdate as Date)
        
        return cell
    }

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
  

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let isResult = RLMManager().deletePersonObject(objPerson: (self.arrPerson?[indexPath.row])!)
            
            if isResult == false {
                YAAppDelegate.getDelegate().toastView(hudType: .YAShowToastMessage, strToastMessage: "There is some error in add. Please try later.")
            } else {
                self.arrPerson = RLMManager().fetchPersonList()
                self.tableView.reloadData()
            }

//            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addEditPerson(isEdit: true, objPerson: self.arrPerson?[indexPath.row])
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        DDLogDebug("\(String(describing: self.arrPerson?[indexPath.row]))")
        let objVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YARealmDetailVC") as! YARealmDetailVC
        objVC.objPerson = (self.arrPerson?[indexPath.row])!
        self.navigationController?.pushViewController(objVC, animated: true)
    }

    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "YARealmDetailVC" {
            DDLogDebug("\(String(describing: sender))")
            let selectedIndex = self.tableView.indexPath(for: sender as! UITableViewCell)
            let vc = segue.destination as! YARealmDetailVC
            vc.objPerson = (self.arrPerson?[(selectedIndex?.row)!])!
        }
    }
    */
}

