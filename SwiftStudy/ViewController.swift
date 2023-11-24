//
//  ViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2017. 3. 15..
//  Copyright © 2017년 Jell PD. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import Foundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var menuArray : NSArray = []

//    var menuArray: Array<String>!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("hihihi");
//        UIDevice.rx.orientation
//            .subscribe(onNext: { current in
//                switch current {
//                case .landscape:
//                    print("landscape")
//                case .portrait:
//                    print("portrait")
//                }
//            })
 
        menuArray = NSArray.init(objects: "구구단", "realm", "IBDesignable", "Drawing", "Category", "SwiftUI", "Landmark list", "Local Push",
//        menuArray = ["구구단", "realm", "IBDesignable", "Drawing", "Category", "SwiftUI", "Landmark list", "Local Push",
//                                 "Rx-Github", "Rx-City", "Rx-chameleon", "Rx-issue",
                                 "SwiftUI-localpush", "SwiftUI-JSONParse", "SwiftUI-ObservableObject", "SwiftUI-RxAlamofire",
//                                 "Realm-tutorial",
//"RxMoya-Github", "RxAlamofire-Github", "RxSwift", "Camera"]
"RxMoya-Github", "RxAlamofire-Github", "RxSwift", "Camera", "KingFisher", "ReactorKit-counter", "FastCampus", "UIKit",
        "Shape", "ReadText", "ReactorKit-Network", "Compositional Layout", "CLHeaderFooter")
//        let menuArr = Observable.of(menuArray)
        
        
//        menuArr
//            .bind(to: mainCollectionView.rx.items(cellIdentifier: "main_collection_view_cell")) { (cell, row, element) in
//            let indexPath = IndexPath(row: row, section: 0)
//            let label = cell.viewWithTag(2) as! UILabel
//            label.text = "\(element) @ \(row)"
//            return cell
//        }.disposed(by: bag)
//        menuArr.bind(to: mainCollectionView.rx.items(cellIdentifier: "main_collection_view_cell", cellType: UICollectionViewCell.self)) { (row, element, cell) in
//            let label = cell.viewWithTag(2) as! UILabel
//            label.text = "\(element) @ \(row)"
//        }.disposed(by: bag)
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
            let vc : RealmMenuViewController = self.storyboard?.instantiateViewController(withIdentifier: "realm_menu") as! RealmMenuViewController;
            self.present(vc, animated: true, completion: nil);
        case 2:
            let vc : IBDesignableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ib_designable") as! IBDesignableViewController
            self.present(vc, animated: true, completion: nil)
        case 3:
            let vc : DrawingViewController = self.storyboard?.instantiateViewController(withIdentifier: "drawing") as! DrawingViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        case 4:
            let vc : CategoryViewController = self.storyboard?.instantiateViewController(withIdentifier: "category") as! CategoryViewController
            self.present(vc, animated: true, completion: nil)
        case 5:
            let vc = UIHostingController(rootView: SwiftUIView(viewModel: SwiftUIViewModel()))
            self.present(vc, animated: true, completion: nil)
        case 6:
            let vc = UIHostingController(rootView: LandmarkList().environmentObject(UserData()))
            self.present(vc, animated: true, completion: nil)
        case 7:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "localpush") as! LocalPushViewController
            self.present(vc, animated: true, completion: nil)
//        case 8:
//            let vc = self.storyboard?
//                .instantiateViewController(withIdentifier: "rxgithub") as! RxGithubViewController
//            self.present(vc, animated: true, completion: nil)
//        case 9:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxcity") as! RxCityViewController
//            self.present(vc, animated: true, completion: nil)
//        case 10:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxchameleon") as! RXChameleonViewController
//            self.present(vc, animated: true, completion: nil)
//        case 11:
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxissue") as! IssueListViewController
//            self.present(vc, animated: true, completion: nil)
        case 8:
            let vc = UIHostingController(rootView: SwiftUILocalPushView())
            self.present(vc, animated: true ){}
        case 9:
            let vc = UIHostingController(rootView: SwiftUIJSONParseView())
            present(vc, animated: true, completion: nil)
        case 10:
            let vc = UIHostingController(rootView: SwiftUIObservableObjectView())
            present(vc, animated: true){}
        case 11:
            let vc = UIHostingController(rootView: RxAlamofireView())
            present(vc, animated: true){}
//        case 16:
//            let vc = self.storyboard?.instantiateViewController(identifier: "realm_tutorial") as! RealmTutorialViewController
//            present(vc, animated: true){}
        case 12:
            let vc = self.storyboard?.instantiateViewController(identifier: "rxmoya_github") as! RxMoyaGithubViewController
            present(vc, animated: true){}
        case 13:
            guard let vc = self.storyboard?.instantiateViewController(identifier: "rxalamofire_github") as? RxAlamoFireGithubViewController else {
                return
            }
            present(vc, animated: true){}
        case 14:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxswift") as! RxSwiftViewController
            present(vc, animated: true){}
        case 15:
            let vc = self.storyboard?.instantiateViewController(identifier: "camera") as! CameraViewController
            present(vc, animated: true){}
        case 16:
            let vc = self.storyboard?.instantiateViewController(identifier: "kingfisher") as! KingFisherViewController
            present(vc, animated: true){}
        case 17:
            let vc = self.storyboard?.instantiateViewController(identifier: "reactorkitcounter") as! ReactorKitCounterViewController
            let reactor = ReactorKitCounterViewReactor()
            vc.reactor = reactor
            present(vc, animated: true){}
        case 18:
            let vc = self.storyboard?.instantiateViewController(identifier: "fc_main") as! FCViewController
            present(vc, animated: true){}
            
        case 19:
            let vc = self.storyboard?.instantiateViewController(identifier: "uikit_main") as! UIKitViewController
            present(vc, animated: true){}
        case 20:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "shape") as! ShapeViewContrller
            present(vc, animated: true)
        case 21:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "readtext") as! ReadTextViewController
            present(vc, animated: true)
        case 22:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "reactorkitnetwork") as! ReactorKitNetworkViewController
            present(vc, animated: true)
        case 23:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "compositional_first") as! CompositionalLayoutFirstViewController
            present(vc, animated: true)
        case 24:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "compositional_headerfooter") as! CompositionalLayoutSupplementaryViewHeaderFooterViewController
            present(vc, animated: true)
        default:
            return;
        }
    }
    
    
}

