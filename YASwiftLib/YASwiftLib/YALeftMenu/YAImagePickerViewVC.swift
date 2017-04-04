//
//  YAImagePickerViewVC.swift
//  YASwiftLib
//
//  Created by Yashica Agrawal on 03/04/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit
import Toast_Swift

class YAImagePickerViewVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {

    @IBOutlet weak var yaImageView: UIImageView!
    @IBOutlet weak var yaButtonReset: UIButton!
    @IBOutlet var yaImageTapGesture: UITapGestureRecognizer!
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image PickerView"

        yaImageView.addBorderAndRoundedCorner(color: colorGrape, borderWidth: 2.0, cornerRadius: 10.0)
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

    @IBAction func yaButtonReset_Clicked(_ sender: UIButton) {
        yaImageView.image = imageLogo
    }
    
    @IBAction func yaImageView_Tap(_ sender: UITapGestureRecognizer) {

        let actionSheet: UIAlertController = UIAlertController(title: "Upload Picture", message: "Choose an Option!", preferredStyle: .actionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true

        let photoAction:UIAlertAction = UIAlertAction(title: "From Photo Library", style: .default) { (action) in
            self.imagePicker.sourceType = .photoLibrary
            
            DispatchQueue.main.async(execute: {
                self.present(self.imagePicker, animated: true, completion: nil)
            })
        }
        
        let savedPhotoAction:UIAlertAction = UIAlertAction(title: "From Saved Photo Album", style: .default) { (action) in
            self.imagePicker.sourceType = .savedPhotosAlbum
            
            DispatchQueue.main.async(execute: {
                self.present(self.imagePicker, animated: true, completion: nil)
            })
        }
        
        let cameraAction:UIAlertAction = UIAlertAction(title: "Take through Camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                
                self.imagePicker.sourceType = .camera
                
                DispatchQueue.main.async(execute: {
                    self.present(self.imagePicker, animated: true, completion: nil)
                })
                
            } else {
                self.toastView(strToastMessage: "Device has no camera")
            }
        }

        actionSheet.addAction(cancelAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(savedPhotoAction)
        actionSheet.addAction(cameraAction)

        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        DispatchQueue.main.async(execute: {
            self.imagePicker.dismiss(animated: true, completion: nil)
        })
        yaImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }

    func toastView(strToastMessage:String) -> Void {
        var style = ToastStyle()
        style.messageAlignment = .center
        style.messageFont = textFontRegular14!
        style.messageColor = colorGrape
        style.backgroundColor = colorLavender
        self.navigationController?.view.makeToast(strToastMessage, duration: 2.0, position: .center, style: style)
    }
}
