//
//  RxCityViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/7/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit

class RxCityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.obscuresBackgroundDuringPresentation = false // UISearchController가 뷰를 흐리게 하는 걸 막는다.
        searchBar.showsCancelButton = true
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = allCities[indexPath.row]
        return cell
    }
}


