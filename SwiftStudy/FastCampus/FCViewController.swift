//
//  FCViewController.swift
//  SwiftStudy
//
//  Created by yoohg on 2021/07/08.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

class FCViewController: UIViewController {
    
    let menuArr = ["Luffy", "Luffy-test"]
    let bag = DisposeBag()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.of(menuArr).bind(to: tableView.rx.items) {(tableView: UITableView, index: Int, element: String) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = element
            return cell
        }.disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: {
            print($0.row)
            switch $0.row {
            case 0:
                let vc = UIHostingController(rootView: FCLuffyView())
                self.present(vc, animated: true){}
            case 1:
                let vc = UIHostingController(rootView: FCLuffyTestView())
                self.present(vc, animated: true){}
            default:
                return
            
            }
        }).disposed(by: bag)
    }
}

