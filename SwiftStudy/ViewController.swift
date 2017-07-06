//
//  ViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2017. 3. 15..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var menuArray : NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("hihihi");
        
        menuArray = NSArray.init(objects: "구구단", "realm", "IBDesignable", "Drawing")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let mainCollectionViewCell : UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "main_collection_view_cell", for: indexPath)
        let label : UILabel = mainCollectionViewCell.viewWithTag(2) as! UILabel;
        label.text = (menuArray.object(at: indexPath.row) as! String);

        return mainCollectionViewCell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc : GugudanViewController = self.storyboard?.instantiateViewController(withIdentifier: "gugudan") as! GugudanViewController;
            self.present(vc, animated: true, completion: nil);
            break;
        case 1:
            let vc : RealmViewController = self.storyboard?.instantiateViewController(withIdentifier: "realm") as! RealmViewController;
            self.present(vc, animated: true, completion: nil);
        case 2:
            let vc : IBDesignableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ib_designable") as! IBDesignableViewController
            self.present(vc, animated: true, completion: nil)
        case 3:
            let vc : DrawingViewController = self.storyboard?.instantiateViewController(withIdentifier: "drawing") as! DrawingViewController
            self.present(vc, animated: true, completion: nil)
        default:
            return;
        }
    }


}

