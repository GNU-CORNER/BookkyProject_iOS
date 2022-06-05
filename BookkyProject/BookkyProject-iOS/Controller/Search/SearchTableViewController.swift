//
//  SearchViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit
import CoreData

class SearchViewController: UITableViewController {
    
    var recentSearchKeyword: [String] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        setDefaultView()
    }

    private func registerNibCell() {
        tableView.register( UINib(nibName: "SearchDefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchDefaultCell" )
        tableView.register( UINib(nibName: "SearchTableHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchDefaultHeaderView" )
    }
    
    private func setDefaultView() {
        CoreDataManager.shared.deleteLastKeyword()
        var tempList: [String] = []
        for searches in CoreDataManager.shared.read(ascending: false) {
            if let keyword = searches.value(forKey: "keyword") as? String {
                tempList.append(keyword)
            }
        }
        self.recentSearchKeyword = tempList
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchKeyword.count
    }
    
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchDefaultHeaderView") as? SearchTableHeaderView else {
            return UITableViewHeaderFooterView()
        }
        headerView.headerTitle.text = "최근 검색"
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchDefaultHeaderView") as? SearchTableHeaderView else {
            return CGFloat()
        }
        return headerView.frame.height
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let userInputText = self.searchController.searchBar.text else {
            print("사용자가 입력한 텍스트를 불러올 수 없음.")
            return
        }
        CoreDataManager.shared.save(keyword: userInputText, date: Date())
        // - [] 검색되는 양, 페이지 모두 무한 스크롤에 맞게 수정해야함 ㅠㅠ
        Books.shared.booksSearch(keyword: userInputText, quantity: 10, page: 1, completionHandler: { (success, data, statuscode) in
            if success {
                guard let decodedData = data as? SearchModel else { return }
                guard let searchResults = decodedData.result?.searchData else { return }
                self.resultsTableViewController.setSearchResults(resultsArray: searchResults)
                
            } else {
                print("통신오류~ \(statuscode)")
            }
        })
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resultsTableViewController.setSearchResults(resultsArray: [])
        setDefaultView()
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
