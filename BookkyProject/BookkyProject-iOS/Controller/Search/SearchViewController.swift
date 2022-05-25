//
//  SearchViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class SearchViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var searchController: UISearchController = UISearchController()
    var searchTableView: UITableViewController = SearchTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController = UISearchController(searchResultsController: searchTableView)
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "제목 또는 태그"
        self.navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        
        self.definesPresentationContext = true
//        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
    }

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("\(searchBar.text)")
        SearchModel.didSearch = true
        searchTableView.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SearchModel.didSearch = false
        searchTableView.tableView.reloadData()
    }
}
