//
//  RxCityViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/7/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit

class RxCityViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    
    override func viewDidLoad() {
        tableView.tableHeaderView = searchController.searchBar
    }
}


