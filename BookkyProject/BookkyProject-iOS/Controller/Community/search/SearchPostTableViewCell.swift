//
//  SearchPostTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit


import UIKit
class SearchPostTableViewCell: UITableViewCell {
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postContentsLabel: UILabel!
    @IBOutlet weak var likeThatImage: UIImageView!
    @IBOutlet weak var likThatCountLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    var PID : Int = 0
    var communityType : Int = 0
    var replyCnt : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBoardTableViewCellUI()
    }
    func setSearchPostList(model : PostSearchData){
        self.postTitleLabel.text = model.title
        self.postContentsLabel.text = model.contents
        self.PID = model.PID
        self.likThatCountLabel.text = "\(model.likeCnt)"
        self.commentLabel.text = "\(model.commentCnt)"
        self.communityType = model.communityType
        self.replyCnt = model.replyCnt
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setBoardTableViewCellUI(){
        self.postTitleLabel.font = UIFont.systemFont(ofSize: 15)
        self.postContentsLabel.font = UIFont.systemFont(ofSize: 13)
        self.postContentsLabel.numberOfLines = 2
        self.postContentsLabel.textColor = UIColor(named: "grayColor")
        self.likeThatImage.image = UIImage(named: "likeThat")
        self.commentImage.image = UIImage(named: "comment")
        self.likThatCountLabel.textColor = UIColor(named: "PrimaryOrangeColor")
        self.likThatCountLabel.font = UIFont.systemFont(ofSize: 12)
        self.commentLabel.textColor = UIColor(named: "PrimaryBlueColor")
        self.commentLabel.font = UIFont.systemFont(ofSize: 12)
    }
}
