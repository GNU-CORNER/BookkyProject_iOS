//
//  SearchTableViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    var filteredBooks: [SearchDatum] = []
    var totalFilteredBooks: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibCell()
//        SearchModel.didSearch = false
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    }
    
    private func registerNibCell() {
        self.tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredBooks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let searchResultCell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as? SearchResultTableViewCell
        else { return UITableViewCell() }
        searchResultCell.searchResultBookTitle.text = "Deep Learning"
        searchResultCell.searchResultBookAuthorLabel.text = "사이토 코기 / 길벗"
        searchResultCell.searchResultBookRateLabel.text = "4.5"
        // 이미지
        return searchResultCell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.estimatedRowHeight
        return CGFloat(height)
    }


}


