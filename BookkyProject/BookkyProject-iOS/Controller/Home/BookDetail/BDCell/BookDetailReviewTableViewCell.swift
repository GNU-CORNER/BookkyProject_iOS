//
//  BookDetailCommentTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/09.
//

import UIKit
import Cosmos
class BookDetailReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewUserNameLabel: UILabel!
    @IBOutlet weak var reviewUserCotents: UILabel!
    @IBOutlet weak var reviewCreateAtLabel: UILabel!
    
    @IBOutlet weak var reviewLikeCntButotn: UIButton!
    
    @IBOutlet weak var reviewAddFunction: ReviewButton!
    @IBOutlet weak var reviewStackView: UIStackView!
    var reviewIsAccessible : Bool = false
    
    @IBOutlet weak var reviewLikeButton: ReviewButton!
    var RID : Int = 0
    var rating : Double = 0.0
    var contents : String = ""
    var isLiked : Bool = false
    @IBOutlet weak var userReviewStarView: CosmosView!
    func updateRating(_ requiredRating: Double?) {
        var newRatingValue : Double = 0.0
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        
        userReviewStarView.rating = newRatingValue
    }
    func starViewUI(){
        userReviewStarView.settings.fillMode = .precise
        userReviewStarView.settings.starSize = 11
    }
    func setReview(model : ReviewData){
        self.reviewUserNameLabel.text = model.nickname
        
        
        self.reviewUserCotents.text = model.contents
        self.reviewCreateAtLabel.text = model.createAt
        self.reviewLikeCntButotn.setTitle("공감(\(model.likeCnt))", for: .normal)
        self.reviewIsAccessible = model.isAccessible
        self.RID = model.RID
        if model.isLiked == true{
            self.reviewLikeCntButotn.tintColor = UIColor(named: "primaryColor")
        }else {
            self.reviewLikeCntButotn.tintColor = UIColor(named: "grayColor")
        }
        self.rating = Double(model.rating)
        self.contents = model.contents
        updateRating(model.rating)
        userReviewStarView.text = "\(model.rating)"
        userReviewStarView.settings.textFont = UIFont.systemFont(ofSize: 11)
    }
    func setTableViewCellUI(){
        self.reviewUserNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        self.reviewUserCotents.font = UIFont.systemFont(ofSize: 12)
        self.reviewCreateAtLabel.font = UIFont.systemFont(ofSize: 10)
        self.reviewLikeCntButotn.tintColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1)
        self.reviewLikeCntButotn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
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
        starViewUI()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
