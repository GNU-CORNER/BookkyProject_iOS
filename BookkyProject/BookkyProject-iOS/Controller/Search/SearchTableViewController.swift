//
//  SearchViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit
import CoreData

class SearchViewController: UITableViewController, UISearchControllerDelegate {
    
    var recentSearchKeyword: [String] = []
    var isLoading: Bool = true
    var page: Int = 1
    var searchController: UISearchController!
    var resultsTableViewController: SearchResultsViewController!
    var getPageDataCount : Int = 0
    var totalSearchCount : Int = 0
    var currentSearchCount : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibCell()
        
        resultsTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultsTableViewController") as? SearchResultsViewController
        resultsTableViewController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableViewController)
        searchController.delegate = self
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
    
    // Table Header View
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
        // FIX: - page, total page
        requestBooksSearch(page: self.page, keyword: userInputText, totalPage: 0, isScroll: false)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resultsTableViewController.setSearchResults(resultsArray: [], isNothing: false, totalPage: 0, isScroll: false)
        setDefaultView()
    }
    
}

extension SearchViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let totalScrollSize = scrollView.contentSize.height - scrollView.bounds.height
        let scrollSize = scrollView.contentOffset.y + 50
        
        if currentSearchCount < totalSearchCount {
            if scrollSize > totalScrollSize  {
                print("끝")
                if isLoading{
                    print("로딩실행")
                    beginFetch()
                }
            }
        
        }
            
        
    }
    
    func beginFetch() {
        isLoading = false
        guard let userInputText = self.searchController.searchBar.text else {
            print("사용자가 입력한 텍스트를 불러올 수 없음.")
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.page += 1
            self.requestBooksSearch(page: self.page, keyword: userInputText, totalPage: 0, isScroll: true)
            
        })
       
     
        
    }
    
    func requestBooksSearch(page: Int, keyword: String, totalPage: Int, isScroll: Bool) {
        Books.shared.booksSearch(keyword: keyword, quantity: 20, page: page, completionHandler: { (success, data, statuscode, total) in
            if success {
                guard let decodedData = data as? SearchModel else { return }
                self.getPageDataCount = decodedData.result?.searchData.count ?? 0
                self.currentSearchCount += self.getPageDataCount
                self.totalSearchCount = decodedData.result?.total ?? 0
                guard let searchResults = decodedData.result?.searchData else { return }
                self.resultsTableViewController.setSearchResults(resultsArray: searchResults, isNothing: false, totalPage: total ?? 0, isScroll: isScroll)
                self.isLoading = true
              
            } else {
                print("통신오류 \(statuscode)")
                if statuscode == 204 {
                    self.resultsTableViewController.setSearchResults(resultsArray: [], isNothing: true, totalPage: 0, isScroll: isScroll)
                }
            }
        })
    }
    
}
