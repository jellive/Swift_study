////
////  IssueListViewController.swift
////  SwiftStudy
////
////  Created by YooHG on 7/8/20.
////  Copyright © 2020 Jell PD. All rights reserved.
////
//
//import UIKit
//import RxSwift
//import RxCocoa
//import Moya
//
//class IssueListViewController: UIViewController {
//
//    @IBOutlet var tableView: UITableView!
//    let searchController = UISearchController(searchResultsController: nil)
//    var searchBar: UISearchBar { // set은 어떻게 넣지?
//        return searchController.searchBar
//    }
//    let disposeBag = DisposeBag()
//    var provider: MoyaProvider<Issue_Github>!
//    var latestRepositoryName: Observable<String> {
//        return searchBar
//            .rx.text
//            .orEmpty
//            .debounce(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.tableHeaderView = searchBar
//        setupRx()
//    }
//
//    var issueTrackerModel: IssueTrackerModel!
//
//    func setupRx() {
//        // Provider 생성
//        provider = MoyaProvider<Issue_Github>()
//
//        issueTrackerModel = IssueTrackerModel(provider: provider, repositoryName: latestRepositoryName)
//
//        issueTrackerModel
//            .trackIssues()
//            .bind(to: tableView.rx.items) { (tableView, row, item) -> UITableViewCell in
//                let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell", for: IndexPath(row: row, section: 0))
//                cell.textLabel?.text = item.title
//
//                return cell
//        }
//        .disposed(by: disposeBag)
//
//        // 유저가 셀을 클릭했을 때 테이블 뷰에게 알려줌.
//        // 만약 키보드가 있다면 숨김.
//        tableView
//            .rx.itemSelected
//            .subscribe(onNext: { IndexPath in
//                if self.searchBar.isFirstResponder == true {
//                    self.view.endEditing(true)
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//}
