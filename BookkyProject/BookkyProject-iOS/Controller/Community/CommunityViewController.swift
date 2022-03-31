//
//  CommunityViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class CommunityViewController: UIViewController {
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
    override func viewDidLoad() {
        super.viewDidLoad()
        //boardNameButton 초기
        self.headerStackView.setCustomSpacing(50, after: boardNameButton)
        self.boardNameButton.setTitle("자유 게시판", for: .normal)
        self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        self.boardNameButton.sizeToFit()
        self.boardNameButton.tintColor = .black
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
            self.boardNameButton.setTitle("자유 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.freeBoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.freeBoardGoButton.tintColor = .black
            self.boardTypeStackView.isHidden = true
            
            //이부분 좀더 간편하게 하는 방법 없을까
            self.hotBoardGobutton.tintColor = UIColor(named: "grayColor")
            self.QnABoardGoButton.tintColor = UIColor(named: "grayColor")
            self.bookMarketGoButton.tintColor = UIColor(named: "grayColor")
            self.myTextGoButton.tintColor = UIColor(named: "grayColor")
        }else if sender == self.hotBoardGobutton{
            self.boardNameButton.setTitle("H🔥t 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.hotBoardGobutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.hotBoardGobutton.tintColor = .black
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.tintColor = UIColor(named: "grayColor")
            self.QnABoardGoButton.tintColor = UIColor(named: "grayColor")
            self.bookMarketGoButton.tintColor = UIColor(named: "grayColor")
            self.myTextGoButton.tintColor = UIColor(named: "grayColor")
        }else if sender == self.QnABoardGoButton{
            self.boardNameButton.setTitle("Q&A 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.QnABoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.QnABoardGoButton.tintColor = .black
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.tintColor = UIColor(named: "grayColor")
            self.hotBoardGobutton.tintColor = UIColor(named: "grayColor")
            self.bookMarketGoButton.tintColor = UIColor(named: "grayColor")
            self.myTextGoButton.tintColor = UIColor(named: "grayColor")
        }else if sender == self.bookMarketGoButton{
            self.boardNameButton.setTitle("책 장터 게시판", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            self.bookMarketGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.bookMarketGoButton.tintColor = .black
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.tintColor = UIColor(named: "grayColor")
            self.hotBoardGobutton.tintColor = UIColor(named: "grayColor")
            self.QnABoardGoButton.tintColor = UIColor(named: "grayColor")
            self.myTextGoButton.tintColor = UIColor(named: "grayColor")
        }else if sender == self.myTextGoButton{
            self.boardNameButton.setTitle("내글 보기", for: .normal)
            self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            
            self.myTextGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            self.myTextGoButton.tintColor = .black
            self.boardTypeStackView.isHidden = true
            
            self.freeBoardGoButton.tintColor = UIColor(named: "grayColor")
            self.hotBoardGobutton.tintColor = UIColor(named: "grayColor")
            self.QnABoardGoButton.tintColor = UIColor(named: "grayColor")
            self.bookMarketGoButton.tintColor = UIColor(named: "grayColor")
            
        }
    }
    
    @IBAction func tapChangeBoard(_ sender: UIButton) {
        if boardTypeStackView.isHidden == false {
            self.boardTypeStackView.isHidden = true
        }else{
            self.boardTypeStackView.isHidden = false
        }
    }
}
