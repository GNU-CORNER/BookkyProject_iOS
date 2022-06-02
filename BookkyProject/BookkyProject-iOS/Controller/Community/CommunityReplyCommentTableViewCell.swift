//
//  CommubityReplyCommentTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/30.
//

import UIKit

class CommunityReplyCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userReplyCommentContentsLabel: UILabel!
    @IBOutlet weak var replyCommentCreateAtLabel: UILabel!
    @IBOutlet weak var replyCommentLikeCntLabel: UILabel!
    @IBOutlet weak var replyTableViewCellStackView: UIStackView!
    @IBOutlet weak var addMoreFunction: UIButton!
    var buttonAction: (()->Void)? = nil
    var isAccessible : Bool = false
    var CID : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BoardTextReplyCommentTableViewCellUI()
    }
    func setComment(model: ChildComment ){
        let likeCount = model.like?.count ?? 0
        self.userReplyCommentContentsLabel.text = model.comment
        self.replyCommentCreateAtLabel.text = model.updateAt
        self.replyCommentLikeCntLabel.text = "공감(\(likeCount))"
        self.userNameLabel.text = model.nickname
        self.isAccessible = model.isAccessible
        self.CID = model.CID
    }
    func setQnAComment(model: QnAChildComment ){
        let likeCount = model.like?.count ?? 0
        self.userReplyCommentContentsLabel.text = model.comment
        self.replyCommentCreateAtLabel.text = model.updateAt
        self.replyCommentLikeCntLabel.text = "공감(\(likeCount))"
        self.userNameLabel.text = model.nickname
        self.isAccessible = model.isAccessible
        self.CID = model.CID
    }
    private func BoardTextReplyCommentTableViewCellUI(){
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.userReplyCommentContentsLabel.font = UIFont.systemFont(ofSize: 12)
        self.replyCommentCreateAtLabel.font = UIFont.systemFont(ofSize: 10)
        self.replyCommentCreateAtLabel.textColor  = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        self.replyCommentLikeCntLabel.font = UIFont.systemFont(ofSize: 10)
        self.replyTableViewCellStackView.backgroundColor = UIColor(named: "lightGrayColor")
        self.replyTableViewCellStackView.layer.cornerRadius = 5
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 20, bottom: 0, right: 10))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapAddFunction(_ sender: UIButton) {
        buttonAction?()
    }
}
