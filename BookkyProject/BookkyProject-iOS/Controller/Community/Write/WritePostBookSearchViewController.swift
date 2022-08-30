//
//  WriteTextSearchBookViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit
protocol SelectSendData : AnyObject {
    func sendData(ImageString:String,bookName: String ,bookAuthorPublisher : String,height : Int,BID : Int)
}
protocol SelectUpdateVCSendData : AnyObject {
    func sendData(ImageString:String,bookName: String ,bookAuthorPublisher : String,height : Int,BID : Int)
}
protocol SelectUpdateCommentVCSendData : AnyObject {
    func sendData(ImageString:String,bookName: String ,bookAuthorPublisher : String,height : Int,BID : Int)
}
class WritePostBookSearchViewController: UIViewController {
    var searchText : String = ""
    var searchBookList : [BookSearchDataList] = []
    var delegate : SelectSendData?
    var updateDelegate : SelectUpdateVCSendData?
    var updateCommentDelegate : SelectUpdateCommentVCSendData?
    var bookName : String = ""
    var bookImg : String = ""
    var bookAP : String = ""
    var BID : Int = 0
    @IBOutlet weak var bookSearchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBookSearchTableView()

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
     
        
    }
    @IBAction func tapCancelViewButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func setBookSearchTableView(){
        self.bookSearchTableView.delegate = self
        self.bookSearchTableView.dataSource = self
    }
    private func getsearchBookdData(){
        CommunityGetAPI.shared.getCommunitySearchBook(searchText: self.searchText) { (success, data) in
            if success {
                guard let searchPostList = data as? BookSearchInformation else { return}
                self.searchBookList = searchPostList.result.searchData
                if searchPostList.success{
                    DispatchQueue.main.async {
                        self.bookSearchTableView.reloadData()
                    }
                }
              
            }
        }
    }
    
}
extension WritePostBookSearchViewController : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchBookList.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bookSearchTableView.frame.width, height: 40))
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.placeholder = "추가할 책 이름을 검색하세요."
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        headerView.addSubview(searchController.searchBar)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = bookSearchTableView.dequeueReusableCell(withIdentifier: "WritePostBookSearchTableViewCellid", for: indexPath)as? WritePostBookSearchTableViewCell else {return UITableViewCell()}
        cell.setBookSearchList(model: self.searchBookList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? WritePostBookSearchTableViewCell else {return}
        self.bookName = cell.bookName
        self.bookImg = cell.UIImageString
        self.bookAP = cell.bookAuthotPublisher
        self.BID = cell.BID
        let Imgstring = self.bookImg
        delegate?.sendData(ImageString:Imgstring , bookName: self.bookName, bookAuthorPublisher: self.bookAP,height:120,BID: self.BID)
        updateDelegate?.sendData(ImageString: Imgstring, bookName: self.bookName, bookAuthorPublisher: self.bookAP, height: 120, BID: self.BID)
        self.presentingViewController?.dismiss(animated: true,completion: nil)
    }
}
extension WritePostBookSearchViewController : UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        self.searchText = searchController.searchBar.text ?? ""
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = true
        getsearchBookdData()
    }
}
