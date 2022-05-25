//
//  SearchTableViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SearchTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibCell()
        SearchModel.didSearch = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    
    private func registerNibCell() {
        self.tableView.register(UINib(nibName: "SearchDefaultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchDefaultCell")
        
        self.tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if SearchModel.didSearch {
            guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultTableViewCell
            else { return UITableViewCell() }
            searchResultCell.searchResultBookTitle.text = "Deep Learning"
            searchResultCell.searchResultBookAuthorLabel.text = "사이토 코기 / 길벗"
            searchResultCell.searchResultBookRateLabel.text = "4.5"
            // 이미지
            return searchResultCell
            
        } else {
            guard let searchDefaultCell = tableView.dequeueReusableCell(withIdentifier: "SearchDefaultCell", for: indexPath) as? SearchDefaultTableViewCell
            else { return UITableViewCell() }
            searchDefaultCell.recentSearchKeywordLabel.text = "모두 다 거짓말이야"
            return searchDefaultCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.estimatedRowHeight
        return CGFloat(height)
    }


}


