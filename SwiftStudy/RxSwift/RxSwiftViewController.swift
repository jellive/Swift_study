//
//  RxSwiftViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 8/26/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxSwiftViewController: UIViewController {
    
    let menuArr = ["Chameleon","city","github","Issuetracker"]
    let bag = DisposeBag()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.of(menuArr).bind(to: tableView.rx.items) {(tableView: UITableView, index: Int, element: String) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
            cell.textLabel?.text = element
            return cell
        }
        .disposed(by: bag)
        
        tableView.rx.itemSelected.subscribe(onNext: {
            print($0.row)
            switch($0.row) {
            case 0:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxchameleon") as! RXChameleonViewController
                self.present(vc, animated: true){}
            case 1:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxcity") as! RxCityViewController
                self.present(vc, animated: true){}
            case 2:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxgithub") as! RxGithubViewController
                self.present(vc, animated: true){}
            case 3:
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "rxissue") as! IssueListViewController
                self.present(vc, animated: true){}
            default:
                return
            }
        }).disposed(by: bag)
    }
}
