//
//  BoardTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/06.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    var PID : Int = 0
    @IBOutlet weak var tableViewCell: UIView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    @IBOutlet weak var likeThatImageView: UIImageView!
    @IBOutlet weak var likeThatCountLabel: UILabel!
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBoardTableViewCellUI()
        
    }
    
    func setBoardTableViewPostList(model :PostListData){
        self.tittleLabel.text = model.title
        self.contentsLabel.text = model.contents
        self.PID = model.PID
        self.likeThatCountLabel.text = "\(model.likeCnt)"
        self.commentCountLabel.text = "\(model.commentCnt)"
        
    }
    func setBoardTableViewCellUI(){
        self.contentsLabel.numberOfLines = 2
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
