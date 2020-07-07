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
        return searchController.searchBar // 기본으로 검색 창이 제공되어 있음. 그걸 쓰면 됨.
        // 근데 왜 주입으로는 안되지? getter로만 되는건가? -> 객체끼리는 초기화 전에 직접 참조가 안되므로 우회하는 방법!
    }
    
    var viewModel = RxGithubViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController() // UISearchController를 설정함.
        
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
        searchController.obscuresBackgroundDuringPresentation = false // UISearchController가 뷰를 흐리게 하는 걸 막는다.
        searchBar.showsCancelButton = true
        searchBar.text = "jellive"
        searchBar.placeholder = "Enter GitHub ID, e.g., \"jellive\""
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    
}
