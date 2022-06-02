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
    }
}
