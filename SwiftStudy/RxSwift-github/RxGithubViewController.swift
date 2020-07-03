//
//  RxGithubViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 7/3/20.
//  Copyright © 2020 Jell PD. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxGithubViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBar: UISearchBar {
        return searchController.searchBar
    }
    
    var viewModel = RxGithubViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        
        viewModel.data.drive(tableView.rx.items(cellIdentifier: "Cell")) {_, repository, cell in
            cell.textLabel?.text = repository.repoName
            cell.detailTextLabel?.text = repository.repoURL
        }
        .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        viewModel.data.asDriver()
            .map{ "\($0.count) Repositories"}
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
    
    func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.text = "Jell"
        searchBar.placeholder = "Enter GitHub ID, e.g., \"jellive\""
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
}
