//
//  WriteTextSearchBookViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class WritePostBookSearchViewController: UIViewController {


    @IBOutlet weak var bookSearchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBookSearchTableView()

    }
    
    @IBAction func tapCancelViewButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    private func setSearchBar(){
        let searchController = UISearchController(searchResultsController: self)
        searchController.searchBar.showsScopeBar = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func setBookSearchTableView(){
        self.bookSearchTableView.delegate = self
        self.bookSearchTableView.dataSource = self
    }

}
extension WritePostBookSearchViewController : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bookSearchTableView.frame.width, height: 50))
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsScopeBar = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        headerView.addSubview(searchController.searchBar)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = bookSearchTableView.dequeueReusableCell(withIdentifier: "WritePostBookSearchTableViewCellid", for: indexPath)as? WritePostBookSearchTableViewCell else {return UITableViewCell()}
        cell.bookImage.image = UIImage(named: "Bookky_Logo")
        cell.bookNameLabel.text =  "리액트 바로가기"
        cell.bookAuthorNPublisher.text = "전인혁/인피니티북스"
        return cell
    }
    
    
    
}

