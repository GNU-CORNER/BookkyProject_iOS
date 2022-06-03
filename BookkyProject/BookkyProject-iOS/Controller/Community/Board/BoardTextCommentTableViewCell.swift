//
//  BoardTextCommentTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/09.
//

import UIKit

class BoardTextCommentTableViewCell: UITableViewCell {
    //textDetailComment 댓글
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userCommentContentsLabel: UILabel!
    @IBOutlet weak var commentCreateAtLabel: UILabel!
    @IBOutlet weak var commentLikeThatCntLabel: UILabel!
    //cnt->count
    @IBOutlet weak var commentFunctionButton: UIButton!
    @IBOutlet weak var TableViewCellContentView: UIView!
    var nickName : String = ""
    func setComment(model: WriteTextDetailCommentdata ){
        let likeCount = model.like?.count ?? 0
        self.userCommentContentsLabel.text = model.comment
        self.commentCreateAtLabel.text = model.updateAt
        self.commentLikeThatCntLabel.text = "공감(\(likeCount))"
        self.userNameLabel.text = model.nickname
        self.nickName = model.nickname
    }
    

    private func BoardTextCommentTableViewCellUI(){
        self.userNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.userCommentContentsLabel.font = UIFont.systemFont(ofSize: 12)
        self.commentCreateAtLabel.font = UIFont.systemFont(ofSize: 10)
        self.commentCreateAtLabel.textColor  = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        self.commentLikeThatCntLabel.font = UIFont.systemFont(ofSize: 10)
        self.TableViewCellContentView.layer.addBorder([.top], color: UIColor(named: "lightGrayColor") ?? UIColor.gray, width: 1)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        BoardTextCommentTableViewCellUI()
       
       
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

