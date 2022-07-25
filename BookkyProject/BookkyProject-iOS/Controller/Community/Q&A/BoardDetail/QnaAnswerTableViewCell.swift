//
//  QnaAnswerTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/16.
//

import UIKit

class QnaAnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createDataLabel: UILabel!
    @IBOutlet weak var choiceAnswerLabel: UILabel!
    @IBOutlet weak var addfunctionButton: UIButton!
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var likeCntLabel: UIButton!
    
    @IBOutlet weak var commentButton: CustomQnAButton!
    @IBOutlet weak var addFunctionButton: CustomQnAButton!
    var PID : Int = 0
    var QnaAnswerisAccessible : Bool = false
    @IBOutlet weak var bookImg: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAPLabel: UILabel!
    @IBOutlet weak var bookViewHeight: NSLayoutConstraint!
    @IBOutlet weak var selectBookView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    func setReplyData(model :WriteTextDetailQnAReplyData ){
        self.userNameLabel.text = model.nickname
        self.createDataLabel.text = model.createAt
        self.contentsLabel.text = model.contents
        self.likeCntLabel.setTitle("좋아요(\(model.like?.count ?? 0))", for: .normal)
        self.choiceAnswerLabel.text = " "
        self.commentButton.setTitle("댓글(\(model.commentCnt ?? 0))", for:.normal)
        self.PID = model.PID
        self.QnaAnswerisAccessible = model.isAccessible
        self.bookNameLabel.text = model.Book?.TITLE
        if model.TBID == 0 {
            self.bookViewHeight.constant = 0
        }else {
            let Author = model.Book?.AUTHOR ?? ""
            let PUBLISHER = model.Book?.PUBLISHER ?? ""
            self.bookAPLabel.text = "\(Author)/\(PUBLISHER)"
            if let url = URL(string: model.Book?.thumbnailImage ?? "") {
                self.bookImg.load(url: url)
            }
        }
        
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    private func setUI(){
        self.userImage.layer.cornerRadius = 5
        self.userNameLabel.font = UIFont.systemFont(ofSize: 14)
        self.createDataLabel.font = UIFont.systemFont(ofSize: 9)
        self.createDataLabel.textColor = UIColor(named: "grayColor")
        self.choiceAnswerLabel.textColor = UIColor(named: "PrimaryBlueColor")
        self.choiceAnswerLabel.font = UIFont.systemFont(ofSize: 11)
        self.contentsLabel.numberOfLines = 0
        self.contentsLabel.font = UIFont.systemFont(ofSize: 12)
        self.likeCntLabel.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.likeCntLabel.tintColor = UIColor(named: "grayColor")
        self.commentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.commentButton.tintColor = UIColor(named: "grayColor")
        self.addFunctionButton.tintColor = .black
// MARK: - BookUI
        self.bookNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.bookAPLabel.font = UIFont.systemFont(ofSize: 12)
        self.selectBookView.layer.borderWidth = 2
        self.selectBookView.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor

    }
}
