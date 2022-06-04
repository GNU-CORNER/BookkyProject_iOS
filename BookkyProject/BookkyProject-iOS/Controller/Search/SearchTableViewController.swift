//
//  SearchViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var recentSearchKeyword: [String] = ["안녕하세요", "React를 검색한다면?", "김뿅뵹인데요", "뭐", "므"]
    
    var searchController: UISearchController!
    var resultsTableViewController: SearchResultsTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibCell()
        
        resultsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsTableViewController") as? SearchResultsTableViewController
        resultsTableViewController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableViewController)
        searchController.delegate = self
//        searchController.searchResultsUpdater = self
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.placeholder = "제목 또는 태그"
        searchController.searchBar.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        
        // 검색바를 네비게이션바에 올리기
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func registerNibCell() {
        self.tableView.register( UINib(nibName: "SearchDefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchDefaultCell" )
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchKeyword.count
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchDefaultCell = tableView.dequeueReusableCell(withIdentifier: "SearchDefaultCell", for: indexPath) as? SearchDefaultTableViewCell else {
            return UITableViewCell()
        }
        
        searchDefaultCell.recentSearchKeywordLabel.text = self.recentSearchKeyword[indexPath.row]
        
        return searchDefaultCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.estimatedRowHeight
        return CGFloat(height)
    }
    
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        SearchModel.didSearch = false
//        resultTableViewController.tableView.reloadData()
    }
    
}

// MARK: - UISearchControllerDelegate

extension SearchViewController: UISearchControllerDelegate {
    
    func presentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //Swift.debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
}
