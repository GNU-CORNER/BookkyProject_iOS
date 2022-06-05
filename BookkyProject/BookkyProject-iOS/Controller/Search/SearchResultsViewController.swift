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
    var resultIsNothing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibCell()
    }
    
    private func registerNibCell() {
        tableView.register( UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell" )
        tableView.register( UINib(nibName: "SearchTableResultHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "SearchResultHeaderView" )
        tableView.register( UINib(nibName: "SearchNoResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchNoResultTableViewCell")
    }
    
    func setSearchResults(resultsArray: [SearchDatum], noResult: Bool) {
        if noResult {
            self.resultIsNothing = true
        }
        self.filteredBooks = resultsArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


// MARK: - Table view data source

extension SearchResultsViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultIsNothing {
            return 1
        } else {
            return filteredBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.resultIsNothing {
            guard let noResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchNoResultTableViewCell", for: indexPath) as? SearchNoResultTableViewCell else {
                return UITableViewCell()
            }
            noResultCell.noResultLabel.text = "검색 결과가 없습니다."
            tableView.separatorStyle = .none
            return noResultCell
            
        } else {
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
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.estimatedRowHeight
        return CGFloat(height)
    }
    
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
