//
//  BoardTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/06.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    var PID : Int = 0
    var communityType : Int = 0
//    var
    @IBOutlet weak var tableViewCell: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var likeThatImageView: UIImageView!
    @IBOutlet weak var likeThatCountLabel: UILabel!
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    var replyCnt : Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBoardTableViewCellUI()
        
    }
    
    func setBoardPostList(model :PostListData){
        self.titleLabel.text = model.title
        self.contentsLabel.text = model.contents
        self.PID = model.PID
        self.likeThatCountLabel.text = "\(model.likeCnt)"
        self.commentCountLabel.text = "\(model.commentCnt)"
        let img = UIImage(named: "comment")! as UIImage
        let redImg = img.imageWithColor(color: UIColor(named: "PrimaryBlueColor") ?? UIColor.blue)
        self.commentImageView.image = redImg
        
    }
    func setBoardHotPostList(model :PostListHotList){
        self.titleLabel.text = model.title
        self.contentsLabel.text = model.contents
        self.PID = model.PID
        self.likeThatCountLabel.text = "\(model.likeCnt)"
        self.commentCountLabel.text = "\(model.commentCnt)"
        self.communityType = model.communityType
        self.replyCnt = model.replyCnt
        let img = UIImage(named: "comment")! as UIImage
        let redImg = img.imageWithColor(color: UIColor(named: "PrimaryBlueColor") ?? UIColor.blue)
        self.commentImageView.image = redImg
    }
    func setBoardMyPostList(model :PostLisyMyList){
        self.titleLabel.text = model.title
        self.contentsLabel.text = model.contents
        self.PID = model.PID
        self.likeThatCountLabel.text = "\(model.likeCnt)"
        self.commentCountLabel.text = "\(model.commentCnt)"
        self.communityType = model.communityType
        self.replyCnt = model.replyCnt
        let img = UIImage(named: "comment")! as UIImage
        let redImg = img.imageWithColor(color: UIColor(named: "PrimaryBlueColor") ?? UIColor.blue)
        self.commentImageView.image = redImg
    }
   
    
    func setBoardTableViewCellUI(){
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.contentsLabel.font = UIFont.systemFont(ofSize: 13)
        self.contentsLabel.textColor = UIColor(named: "grayColor")
        self.likeThatImageView.image = UIImage(named: "likeThat")
        self.commentImageView.image = UIImage(named: "comment")
        self.likeThatCountLabel.textColor = UIColor(named: "PrimaryOrangeColor")
        self.commentCountLabel.textColor = UIColor(named: "PrimaryBlueColor")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
