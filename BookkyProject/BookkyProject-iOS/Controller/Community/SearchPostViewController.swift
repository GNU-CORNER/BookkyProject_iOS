//
//  SearchPostViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class SearchPostViewController: UIViewController {

    @IBOutlet weak var searchPostTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setSearchBar()
        setTableView()
        seSearchTableViewCell()
    }
    private func setSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsScopeBar = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func setNavigationBar(){
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    private func setTableView(){
        self.searchPostTableView.delegate = self
        self.searchPostTableView.dataSource = self
    }
    private func seSearchTableViewCell(){
        let cellNib = UINib(nibName: "SearchPostTableViewCell", bundle: nil)
        self.searchPostTableView.register(cellNib, forCellReuseIdentifier: "searchTableViewCellNib")
    }
   
}
extension SearchPostViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchPostTableView.dequeueReusableCell(withIdentifier: "searchTableViewCellNib", for: indexPath) as? SearchPostTableViewCell else {return UITableViewCell()}
        cell.postTitleLabel.text = "위글 위글위글 위글위글 위글위글 위글위글 위글위글 위글"
        cell.postContentsLabel.text = "테스트테스트테스트테스트테스트\n테스트테스트테스트"
        cell.likeThatImage.image = UIImage(named: "likeThat")
        cell.commentImage.image = UIImage(named: "comment")
        return cell
    }
  
}
