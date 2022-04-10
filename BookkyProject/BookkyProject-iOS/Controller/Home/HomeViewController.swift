//
//  ViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/13.
//refactor

import UIKit


class HomeViewController: UIViewController, UICollectionViewDelegate {
    let user = "황랑귀"
//    let bookList = BookData()
    
    var bookList : [BookList] = []
    
    @IBOutlet weak var welcomeTextStackView: UIStackView!
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var noticeButton: UIButton!
    
    @IBOutlet weak var bookListTabelView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.noticeButton.setImage(UIImage(systemName: "bell"), for: .normal)
        self.setWelcomeTextLabel()
        self.setBookTableView()
        self.getBookData()
        self.bookListTabelView.alwaysBounceVertical = false
   
        
    }
    
    private func setWelcomeTextLabel(){
        self.welcomeTextStackView?.backgroundColor = UIColor(named: "primaryColor")
        self.welcomeTextLabel.text = "오늘\n\(user)님에게\n추천하는 책이에요 !"
        self.welcomeTextLabel.numberOfLines = 3
        self.welcomeTextLabel.sizeToFit()
        self.welcomeTextLabel.font = UIFont.systemFont(ofSize: 22)
        
        
    }
    
    private func setBookTableView(){
        self.bookListTabelView.dataSource = self
        self.bookListTabelView.delegate = self
        
        let cellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.bookListTabelView.register(cellNib, forCellReuseIdentifier: "BookTableViewCellid")
        
    }
     func getBookData(){
        GetBookData.shared.getBookData() { (sucess,data) in
            if sucess {
                guard let bookData = data as? BookInformation else {return}
                //                print("\(BookData)")
                self.bookList = bookData.result.bookList
             
                if bookData.success{
                    DispatchQueue.main.async {
                        self.bookListTabelView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
            }
        }
    }
   
    
}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(bookList.count)r")
        return bookList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:BookTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCellid", for: indexPath) as? BookTableViewCell else { return UITableViewCell()}
        
        cell.setBookInformation(model: bookList[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
 
    
}

