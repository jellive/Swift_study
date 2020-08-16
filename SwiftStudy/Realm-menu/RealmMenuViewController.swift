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

class RealmMenuViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    
    let menuArr = ["Realm", "Realm-tutorial"]
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.rx.setDelegate(self).disposed(by: bag)
        tableView.delegate = self
         
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print("\(indexPath)")
        })
        .disposed(by: bag)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        cell.detailTextLabel?.text = menuArr[indexPath.row]
        return cell
    }
    
    
}
