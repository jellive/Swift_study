//
//  RealmMenuViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2020/08/07.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa

class RealmMenuViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let menuArr = ["Realm", "Realm-tutorial"]
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.rx.setDelegate(self).disposed(by: bag)
//        tableView.delegate = self
         
        let menuOb = Observable.of(menuArr)
        menuOb.bind(to: tableView.rx.items) { (tableView: UITableView, index: Int, element: String) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
            cell.textLabel?.text = element
            return cell
        }.disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                switch indexPath.row {
//                    case 0:
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "realm") as! RealmViewController
//                        self.present(vc, animated: true){}
                    case 1:
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "realm_tutorial") as! RealmTutorialViewController
                        self.present(vc, animated: true){}
                    default:
                        print("\(indexPath)")
                }
            })
        })
        .disposed(by: bag)
    }
    
    
    
}
