//
//  SearchTableViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SearchResultsViewController: UITableViewController {

    var searchKeyword: String = ""
    var filteredBooks: [SearchDatum] = []
    var totalFilteredBooks: Int = 0
    var isNothing: Bool = false
    var isLoading: Bool = false
    var totalPage: Int = 1
    var presentPage: Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibCell()
    }
    
    private func registerNibCell() {
        tableView.register( UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell" )
        tableView.register( UINib(nibName: "SearchTableResultHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchResultHeaderView" )
        tableView.register( UINib(nibName: "SearchNoResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchNoResultTableViewCell" )
        tableView.register( UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell" )
    }
    
    func setSearchResults(resultsArray: [SearchDatum], noResult: Bool, totalPage: Int, isScroll: Bool) {
        if noResult {
            self.isNothing = noResult
        } else {
            self.isNothing = noResult
        }
        
        if isScroll {
            self.filteredBooks.append(contentsOf: resultsArray)
        } else {
            self.filteredBooks = resultsArray
        }
        
        self.totalPage = totalPage
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("안녕12")
        let scrollSize = self.tableView.contentOffset.y
        let totalScrollSize = self.tableView.contentSize.height - self.tableView.bounds.size.height
        if (scrollSize > totalScrollSize) && !isLoading {
            requestBooksSearch(page: self.presentPage, keyword: self.searchKeyword, totalPage: self.totalPage)
            print("안녕1")
        }
        print("안녕12")
    }
    
}


// MARK: - Table view data source

extension SearchResultsViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        if self.isNothing {
            return 1
        } else {
            return 2
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isNothing { // - [x] 검색 결과가 없을 경우
            return 1
        } else {            // - [x] 검색 결과가 있을 경우
            if section == 0 {
                return filteredBooks.count
            } else if section == 1 {
                return 1
            } else {
                return 0
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // - [x] 검색 결과가 없을 경우
        if self.isNothing {
            guard let noResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchNoResultTableViewCell", for: indexPath) as? SearchNoResultTableViewCell else {
                return UITableViewCell()
            }
            noResultCell.noResultLabel.text = "검색 결과가 없습니다."
            tableView.separatorStyle = .none
            return noResultCell
        // - [x] 검색 결과가 있을 경우
        } else {
            // - [x] 데이터가 보여지는 곳
            if indexPath.section == 0 {
                guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultTableViewCell else {
                    return UITableViewCell()
                }
                searchResultCell.searchResultBookTitle.text = filteredBooks[indexPath.row].title
                searchResultCell.searchResultBookAuthorLabel.text = filteredBooks[indexPath.row].author
                searchResultCell.searchResultBookRateLabel.text = String(filteredBooks[indexPath.row].rating)
                // 이미지
                if let thumbnailURL = URL(string: filteredBooks[indexPath.row].thumbnailImage) {
                    do {
                        let thumbnailData = try Data(contentsOf: thumbnailURL)
                        searchResultCell.searchResultBookImageView.image = UIImage(data: thumbnailData)
                    } catch {
                        print(error)
                    }
                }
                searchResultCell.setBookTags(tagArray: filteredBooks[indexPath.row].tagData)
                tableView.separatorStyle = .singleLine
                return searchResultCell
            // - [x] Activity Indicator
            } else if indexPath.section == 1{
                guard let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell else {
                    return UITableViewCell()
                }
                loadingCell.activityIndicator.startAnimating()
                return loadingCell
            } else {
                return UITableViewCell()
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.estimatedRowHeight
        return CGFloat(height)
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}


extension SearchResultsViewController {
    
    // Table Header View
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchResultHeaderView") as? SearchTableResultHeaderView else {
            return UITableViewHeaderFooterView()
        }
        headerView.headerTitle.text = "\(searchKeyword)으로 검색한 결과에요"
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SearchResultHeaderView") as? SearchTableResultHeaderView else {
            return CGFloat()
        }
        return headerView.frame.height
    }
    
}

extension SearchResultsViewController {
    
    func requestBooksSearch(page: Int, keyword: String, totalPage: Int) {
//        if !self.isLoading {
            self.isLoading = true
//            DispatchQueue.global().async {
//                sleep(1)
                if page <= totalPage {
                    Books.shared.booksSearch(keyword: keyword, quantity: 20, page: page, completionHandler: {(success, data, statuscode, page) in
                        if success {
                            guard let decodeData = data as? SearchModel else { return }
                            guard let searchResult = decodeData.result?.searchData else { return }
                            self.setSearchResults(resultsArray: searchResult, noResult: false, totalPage: totalPage, isScroll: true)
                            self.presentPage += 1
                            print("안녕")
                            print(searchResult)
                        } else {
                            print("서치 안된다ㅏ")
                        }
                    })
//                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.isLoading = false
//                    }
                }
//            }
//        }
    }
    
    
}
