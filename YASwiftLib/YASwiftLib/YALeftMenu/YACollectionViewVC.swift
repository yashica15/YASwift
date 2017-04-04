//
//  YACollectionViewVC.swift
//  YASwiftLib
//
//  Created by Yashica Agrawal on 03/04/17.
//  Copyright © 2017 Yashica Agrawal. All rights reserved.
//

import UIKit

class YACollectionViewVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    let reuseIdentifier = "YACellCollectionView" // also enter this string as the cell identifier in the storyboard

    @IBOutlet weak var yaCollectionView: UICollectionView!
    
    var arrYAImage = [YAImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Collection View"

        arrYAImage = [
            YAImage(imageURL:"https://ibb.co/eNUzGF", imageName:"Summer 1"),
            YAImage(imageURL:"https://ibb.co/mfotbF", imageName:"Summer 2"),
            YAImage(imageURL:"https://ibb.co/cxQH3v", imageName:"Summer 3"),
            YAImage(imageURL:"https://ibb.co/b4BqOv", imageName:"Summer 4"),
            YAImage(imageURL:"https://ibb.co/fLavqa", imageName:"Summer 5"),
            YAImage(imageURL:"https://ibb.co/nnweGF", imageName:"Summer 6"),
            YAImage(imageURL:"https://ibb.co/dXLjiv", imageName:"Summer 7"),
            YAImage(imageURL:"https://ibb.co/cK6DbF", imageName:"Summer 8"),
            YAImage(imageURL:"https://ibb.co/ipeMVa", imageName:"Summer 9"),
            YAImage(imageURL:"https://ibb.co/dfwDbF", imageName:"Summer 10"),
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
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }

}
