//
//  RealmMenuViewController.swift
//  SwiftStudy
//
//  Created by Jell PD on 2020/08/07.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RealmMenuViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: bag)
        
    }
}
