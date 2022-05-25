//
//  BookDetailCommentTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/09.
//

import UIKit

class BookDetailReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewUserNameLabel: UILabel!
    @IBOutlet weak var reviewUserRatingLabel: UILabel!
    @IBOutlet weak var reviewUserCotents: UILabel!
    @IBOutlet weak var reviewCreateAtLabel: UILabel!
    @IBOutlet weak var reviewLikeCnt: UILabel!
    
    @IBOutlet weak var reviewStackView: UIStackView!
    func setReview(model : ReviewData){
        self.reviewUserNameLabel.text = model.nickname
        self.reviewUserRatingLabel.text = "\(model.rating)"
        self.reviewUserCotents.text = model.contents
        self.reviewCreateAtLabel.text = model.createAt
        self.reviewLikeCnt.text = "공감(\(model.likeCnt))"
    }
    func setTableViewCellUI(){
        self.reviewUserNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.reviewUserRatingLabel.font = UIFont.systemFont(ofSize: 10)
        self.reviewUserCotents.font = UIFont.systemFont(ofSize: 12)
        self.reviewCreateAtLabel.font = UIFont.systemFont(ofSize: 10)
        self.reviewCreateAtLabel.textColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        self.reviewLikeCnt.font = UIFont.systemFont(ofSize: 10)
        self.reviewStackView.layer.borderWidth = 1
        self.reviewStackView.layer.borderColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor
        self.reviewStackView.layer.cornerRadius = 10
        
    }
    //테이블뷰 셀간의 간격
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setTableViewCellUI()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
