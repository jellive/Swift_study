//
//  RxCityViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/7/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.obscuresBackgroundDuringPresentation = false // UISearchController가 뷰를 흐리게 하는 걸 막는다.
        searchBar.showsCancelButton = true
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = self
        
        searchBar
            .rx.text // RxCocoa의 Observable 속성
        .orEmpty // 옵셔널 해제
            .subscribe(onNext: { [unowned self] query in // 새로운 값에 대한 알림을 받음. unowned는...?
                print("query: \(query)")
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // 일치하는 친구만 찾아서 shownCities에 쑉
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag) // 기본적으로 observable은 사라지지 않지만 여기에 담으면 뷰가 해제될 때 같이 해제할 수 있다.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
}


