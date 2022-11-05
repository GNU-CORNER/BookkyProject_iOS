//
//  SearchPostViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class SearchPostViewController: UIViewController {

    @IBOutlet weak var searchPostTableView: UITableView!
    var searchText : String = ""
    var searchPostList : [PostSearchData] = []
    var PID : Int = 0
    var boardTypeNumber : Int  = 0
    var replyCnt : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setSearchBar()
        setTableView()
        searchTableViewCell()
        self.keyboardDown()
    }
    private func setSearchBar(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.placeholder = "검색할 글 제목을 입력하세요"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
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
    private func searchTableViewCell(){
        let cellNib = UINib(nibName: "SearchPostTableViewCell", bundle: nil)
        self.searchPostTableView.register(cellNib, forCellReuseIdentifier: "searchTableViewCellNib")
        let QnAcellNib = UINib(nibName: "QnABoardTableViewCell", bundle: nil)
        self.searchPostTableView.register(QnAcellNib, forCellReuseIdentifier: "QnATableVIewCellid")
    }
    private func getsearchData(){
        CommunityGetAPI.shared.getCommunitySearchPost(searchText: self.searchText) { (success, data) in
            if success {
                guard let searchPostList = data as? PostSearchModel else { return}
                self.searchPostList = searchPostList.result
                if searchPostList.success{
                    DispatchQueue.main.async {
                        self.searchPostTableView.reloadData()
                    }
                }
              
            }
        }
    }
}
extension SearchPostViewController : UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        self.searchText = searchController.searchBar.text ?? ""
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getsearchData()
    }
    
}
extension SearchPostViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchPostList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCellNib", for: indexPath) as? SearchPostTableViewCell else {return UITableViewCell()}
        guard let QnACell = searchPostTableView.dequeueReusableCell(withIdentifier: "QnATableVIewCellid", for: indexPath) as? QnABoardTableViewCell else { return UITableViewCell()}
        if searchPostList[indexPath.row].communityType == 2{
            QnACell.searchPostList(model: searchPostList[indexPath.row])
            return QnACell
        }else {
            cell.setSearchPostList(model: searchPostList[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.replyCnt = self.searchPostList[indexPath.row].replyCnt
        if self.replyCnt == -1 {
            guard let cell = tableView.cellForRow(at: indexPath) as? SearchPostTableViewCell else {return }
            guard let BoardTextDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController") as? BoardTextDetailViewController else {return}
            BoardTextDetailViewController.PID = cell.PID
            BoardTextDetailViewController.boardTypeNumber = cell.communityType
            self.navigationController?.pushViewController(BoardTextDetailViewController, animated: true)
        }else {
            guard let QnACell = tableView.cellForRow(at: indexPath) as? QnABoardTableViewCell else {return}
            let QnAStoryboard : UIStoryboard = UIStoryboard(name:"QnACommunity" , bundle: nil)
            guard let QnABoardTextDetailViewController = QnAStoryboard.instantiateViewController(withIdentifier: "QnABoardViewController") as? QnABoardTextDetailViewController else {return}
            QnABoardTextDetailViewController.PID = QnACell.PID
            QnABoardTextDetailViewController.boardTypeNumber = QnACell.communityType
            self.navigationController?.pushViewController(QnABoardTextDetailViewController, animated: true)
        }
    }
}
