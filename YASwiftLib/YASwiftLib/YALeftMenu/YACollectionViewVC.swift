//
//  YACollectionViewVC.swift
//  YASwiftLib
//
//  Created by Yashica Agrawal on 03/04/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit

class YACollectionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let reuseIdentifier = "YACellCollectionView" // also enter this string as the cell identifier in the storyboard

    @IBOutlet weak var yaCollectionView: UICollectionView!
    
    var arrYAImage = [YAImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Collection View"

        arrYAImage = [
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2015/12/Nice-Image.png", imageName:"Colors"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2017/02/Tree-Autumn-Background.jpg", imageName:"Tree Autumn"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2017/03/Beautiful-Mountains-Wallpaper.jpg", imageName:"Beautiful Mountains"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2017/02/Awesome.jpg", imageName:"Autumn"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2017/02/Free-Autumn-Background.png", imageName:"Autumn"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2017/02/Best-Autumn-Background.jpg", imageName:"Autumn"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2016/10/Wallpaper-Of-Niagara-Falls.jpg", imageName:"Niagara Falls.jpg"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2016/10/Widescreen-Niagara-Falls-Wallpaper.jpg", imageName:"Niagara-Falls"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2016/10/Sea-Niagara-Falls.jpg", imageName:"Sea Niagara Falls"),
            YAImage(imageURL:"http://hdwpro.com/wp-content/uploads/2016/04/Wonderful-Life.jpeg", imageName:"Wonderful-Life"),
            ]
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

    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrYAImage.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! YACellCollectionView
        
        cell.imgYACellAsync.placeholderImage = imageLogo
        let objImage:YAImage = self.arrYAImage[indexPath.item]
        cell.imgYACellAsync.url = URL(string: objImage.imageURL)! as NSURL
        cell.lblYACell.text = objImage.imageName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat
        if kIS_IPAD {
            width = kSCREEN_WIDTH/5.5
        } else {
            width = kSCREEN_WIDTH/3.5
        }
        return CGSize(width: width, height: width*1.2)
    }

    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }

}
