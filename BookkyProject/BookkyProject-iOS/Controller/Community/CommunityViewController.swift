//
//  CommunityViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class CommunityViewController: UIViewController {
    var boardTypeNumber : Int = 0
    let freeBoard = Free()
    let QnABoard = QnA()
    let HotBoard = Hot()
    let bookMarketBoard = BookMarket()
    let myTextBoard = Mytext()
    
    @IBOutlet var communityView: UIView!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var boardNameButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var writeTextButton: UIButton!
    @IBOutlet weak var freeBoardGoButton: UIButton!
    @IBOutlet weak var hotBoardGobutton: UIButton!
    @IBOutlet weak var QnABoardGoButton: UIButton!
    @IBOutlet weak var bookMarketGoButton: UIButton!
    @IBOutlet weak var myTextGoButton: UIButton!
    @IBOutlet weak var boardTypeStackView: UIStackView!
    //tableView
    @IBOutlet weak var boardTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.boardTableView.reloadData()
        boardTableView.delegate = self
        boardTableView.dataSource = self
        
        self.freeBoardGoButton.setTitle("자유", for: .normal)
        self.hotBoardGobutton.setTitle("HOT", for: .normal)
        self.QnABoardGoButton.setTitle("Q&A", for: .normal)
        self.bookMarketGoButton.setTitle("책 장터", for: .normal)
        self.myTextGoButton.setTitle("내 글 보기", for: .normal)
        
        self.freeBoardGoButton.setTitleColor(.black, for: .normal)
        //boardNameButton 초기
        self.headerStackView.setCustomSpacing(50, after: boardNameButton)
        self.boardNameButton.setTitle("자유 게시판", for: .normal)
        self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        self.boardNameButton.sizeToFit()
        self.boardNameButton.tintColor = .black
        //보드게시판 클릭 초기
        
        //searchButton
        self.searchButton.tintColor = .black
        //writeTextButton
        self.writeTextButton.backgroundColor = UIColor(named: "primaryColor")
        self.writeTextButton.sizeToFit()
        self.writeTextButton.tintColor = .white
        self.writeTextButton.layer.borderWidth = 2
        self.writeTextButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        self.writeTextButton.layer.cornerRadius = 10
        self.boardTypeStackView.layer.borderWidth = 2
        self.boardTypeStackView.layer.borderColor = UIColor.black.cgColor
        self.boardTypeStackView.layer.cornerRadius = 10
        self.boardTypeStackView.sizeToFit()
        boardTypeColor()
        
    }
    private func boardTypeColor() {
        self.freeBoardGoButton.tintColor = UIColor(named: "grayColor")
        self.hotBoardGobutton.tintColor = UIColor(named: "grayColor")
        self.QnABoardGoButton.tintColor = UIColor(named: "grayColor")
        self.bookMarketGoButton.tintColor = UIColor(named: "grayColor")
        self.myTextGoButton.tintColor = UIColor(named: "grayColor")
    }
    
    //button 선택에 따라 게시판 이름 바뀜
    @IBAction func tapGoBoard(_ sender: UIButton) {
        
        if sender == self.freeBoardGoButton{
            self.boardTypeNumber = 0
            self.boardNameButton.setTitle("자유 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.freeBoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.freeBoardGoButton.setTitleColor(.black, for: .normal)
            self.boardTypeStackView.isHidden = true
            
            //이부분 좀더 간편하게 하는 방법 없을까
            self.hotBoardGobutton.setTitleColor(.gray, for: .normal)
            self.QnABoardGoButton.setTitleColor(.gray, for: .normal)
            self.bookMarketGoButton.setTitleColor(.gray, for: .normal)
            self.myTextGoButton.setTitleColor(.gray, for: .normal)
            
        }else if sender == self.hotBoardGobutton{
            self.boardTypeNumber = 1
            self.boardNameButton.setTitle("H🔥t 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.hotBoardGobutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.hotBoardGobutton.setTitleColor(.black, for: .normal)
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.setTitleColor(.gray, for: .normal)
            self.QnABoardGoButton.setTitleColor(.gray, for: .normal)
            self.bookMarketGoButton.setTitleColor(.gray, for: .normal)
            self.myTextGoButton.setTitleColor(.gray, for: .normal)
            
        }else if sender == self.QnABoardGoButton{
            self.boardTypeNumber = 2
            self.boardNameButton.setTitle("Q&A 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.QnABoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.QnABoardGoButton.setTitleColor(.black, for: .normal)
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.setTitleColor(.gray, for: .normal)
            self.hotBoardGobutton.setTitleColor(.gray, for: .normal)
            self.bookMarketGoButton.setTitleColor(.gray, for: .normal)
            self.myTextGoButton.setTitleColor(.gray, for: .normal)
            
        }else if sender == self.bookMarketGoButton{
            self.boardTypeNumber = 3
            self.boardNameButton.setTitle("책 장터 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            self.bookMarketGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.bookMarketGoButton.setTitleColor(.black, for: .normal)
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.setTitleColor(.gray, for: .normal)
            self.hotBoardGobutton.setTitleColor(.gray, for: .normal)
            self.QnABoardGoButton.setTitleColor(.gray, for: .normal)
            self.myTextGoButton.setTitleColor(.gray, for: .normal)
            
        }else if sender == self.myTextGoButton{
            self.boardTypeNumber = 4
            self.boardNameButton.setTitle("내글 보기", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.myTextGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.myTextGoButton.setTitleColor(.black, for: .normal)
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.setTitleColor(.gray, for: .normal)
            self.hotBoardGobutton.setTitleColor(.gray, for: .normal)
            self.QnABoardGoButton.setTitleColor(.gray, for: .normal)
            self.bookMarketGoButton.setTitleColor(.gray, for: .normal)
        }
        self.boardTableView.reloadData()
    }
    
    @IBAction func tapChangeBoard(_ sender: UIButton) {
        
        if boardTypeStackView.isHidden == false {
            self.boardTypeStackView.isHidden = true
            self.boardTableView.backgroundColor = .white
        }else{
            self.boardTypeStackView.isHidden = false
            self.boardTypeStackView.backgroundColor = .white
            self.communityView.bringSubviewToFront(self.boardTypeStackView)
            self.boardTableView.backgroundColor = .gray
            
        }
        self.boardTableView.reloadData()
    }
}
extension CommunityViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boardTableView.dequeueReusableCell(withIdentifier: "boadrTableViewCellid", for: indexPath) as! BoardTableViewCell
        cell.tittleLabel.text = freeBoard.objectArray[indexPath.row].title
        cell.subtittleLabel.text = freeBoard.objectArray[indexPath.row].subtitle
        
        if boardTypeStackView.isHidden == false{
            cell.backgroundColor = .gray
        }else {
            cell.backgroundColor = .white
            self.boardTableView.backgroundColor = .white
        }
        if boardTypeNumber == 0 {
            cell.tittleLabel.text = freeBoard.objectArray[indexPath.row].title
            cell.subtittleLabel.text = freeBoard.objectArray[indexPath.row].subtitle
            
        }else if boardTypeNumber == 1{
            cell.tittleLabel.text = HotBoard.objectArray[indexPath.row].title
            cell.subtittleLabel.text = HotBoard.objectArray[indexPath.row].subtitle
            
        }
        else if boardTypeNumber == 2{
            cell.tittleLabel.text = QnABoard.objectArray[indexPath.row].title
            cell.subtittleLabel.text = QnABoard.objectArray[indexPath.row].subtitle
            
        }else if boardTypeNumber == 3{
            cell.tittleLabel.text = bookMarketBoard.objectArray[indexPath.row].title
            cell.subtittleLabel.text = bookMarketBoard.objectArray[indexPath.row].subtitle
            
        }else if boardTypeNumber == 4{
            cell.tittleLabel.text = myTextBoard.objectArray[indexPath.row].title
            cell.subtittleLabel.text = myTextBoard.objectArray[indexPath.row].subtitle
            
            
        }
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
