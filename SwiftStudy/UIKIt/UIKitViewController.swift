//
//  UIKitViewController.swift
//  SwiftStudy
//
//  Created by dongwoo on 9/2/21.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import UIKit

class UIKitViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    var menuArray: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        
        menuArray = NSArray.init(object: "Rounded Popup")
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainCollectionViewCell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ui_main_collection_view_cell", for: indexPath)
        let label : UILabel = mainCollectionViewCell.viewWithTag(2) as! UILabel;
        label.text = (menuArray.object(at: indexPath.row) as! String);

        return mainCollectionViewCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch(indexPath.row) {
        case 0:
            let vc = self.storyboard?.instantiateViewController(identifier: "ui_popup_round") as! UIPopupRoundViewController
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        default:
            return
        }
    }
}
