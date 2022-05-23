//
//  TagMoreButtonViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/11.
//

import UIKit

class TagMoreButtonViewController: UIViewController,UICollectionViewDelegate{
    var userName = "북키"
    var buttonText = "태그 더보기>"
    var bookList : [TagmoreViewBookList] = []
    var BID : Int = 0
    var TID : Int = 0
    @IBOutlet weak var navigationBarRightButton: UIBarButtonItem!
    @IBOutlet weak var tagMoreBookListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setBookListTableView()
        getBookList()
        getTagViewBookData()
    }
    //MARK: - 상태바
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    private func setNavigationBar(){
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
//        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "PrimaryBlueColor")
        self.navigationBarRightButton.tintColor = UIColor.black
    }
    private func setBookListTableView(){
        self.tagMoreBookListTableView.alwaysBounceVertical = false //헤더 고정 풀기
        self.tagMoreBookListTableView.delegate = self
        self.tagMoreBookListTableView.dataSource = self
        let cellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tagMoreBookListTableView.register(cellNib, forCellReuseIdentifier: "BookTableViewCellid")
    }
    private func getBookList(){
        
    }
    private func getTagViewBookData(){
        GetBookData.shared.getTagMoreViewBookData(){ (sucess,data) in
            if sucess {
                guard let bookData = data as? TagMoreViewBookInformation else {return}
                self.bookList = bookData.result.bookList
                self.userName = bookData.result.nickname
                if bookData.success{
                    DispatchQueue.main.async {
                        self.tagMoreBookListTableView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
            }
        }
    }
}
extension TagMoreButtonViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 230
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tagMoreBookListTableView.frame.width, height: 120))
        headerView.backgroundColor = UIColor(named: "primaryColor")
        let welComeLabel = UILabel(frame: CGRect(x: self.tagMoreBookListTableView.frame.width*(1/15), y: 0, width: self.tagMoreBookListTableView.frame.width*(2/3), height: 120))
        headerView.addSubview(welComeLabel)
        welComeLabel.text = "북키가\n\(self.userName)님에게\n추천하는 책이에요!"
        welComeLabel.adjustsFontSizeToFitWidth = true
        welComeLabel.numberOfLines = 3
        welComeLabel.font = UIFont.systemFont(ofSize: 24)
        welComeLabel.sizeToFit()
        welComeLabel.textColor = UIColor.white
        welComeLabel.asColr(targetString: userName, color: .black)
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:BookTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCellid", for: indexPath) as? BookTableViewCell else { return UITableViewCell()}
        cell.setTagMoreViewInformation(model: bookList[indexPath.row])
        cell.cellDelegate = self
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TagMoreBookDetailViewSegue"{
            let BookDetailViewController = segue.destination as! BookDetailViewController
            BookDetailViewController.BID = self.BID
        }else if segue.identifier == "TagMoreBookTagViewSegue"{
            guard let tagViewController = segue.destination as? TagViewController else {return}
            tagViewController.TID = self.TID
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? BookTableViewCell else {return}
        self.TID = cell.TID
        print("\(self.TID)")
        performSegue(withIdentifier: "TagMoreBookTagViewSegue", sender: indexPath.row)
    }
    
}
extension TagMoreButtonViewController : BookCollectionViewCellDeleGate{
    func collectionView(collectionviewcell: BookCollectionViewCell?, index: Int, didTappedInTableViewCell: BookTableViewCell) {
        self.BID = collectionviewcell?.BID ?? 0
        
        performSegue(withIdentifier: "TagMoreBookDetailViewSegue", sender: self)
    }
    
    
}
