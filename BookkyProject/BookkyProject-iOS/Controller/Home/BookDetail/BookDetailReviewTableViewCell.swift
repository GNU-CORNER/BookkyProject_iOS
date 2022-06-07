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
    
    @IBOutlet weak var reviewLikeCntButotn: UIButton!
    
    @IBOutlet weak var reviewAddFunction: ReviewButton!
    @IBOutlet weak var reviewStackView: UIStackView!
    var reviewIsAccessible : Bool = false
    @IBOutlet weak var reviewRatingStarImageView: UIImageView!
    @IBOutlet weak var reviewLikeButton: ReviewButton!
    var RID : Int = 0
    var rating : Float = 0.0
    var contents : String = ""
    var isLiked : Bool = false
    func setReview(model : ReviewData){
        self.reviewUserNameLabel.text = model.nickname
        self.reviewUserRatingLabel.text = "\(model.rating)"
        
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
        self.rating = Float(model.rating)
        self.contents = model.contents
        switch model.rating {
        case 0 :
            self.reviewRatingStarImageView.image = UIImage(named: "starZero")
        case 0..<0.5:
            self.reviewRatingStarImageView.image = UIImage(named: "starZeroHalf")
        case 0.5..<1.0:
            self.reviewRatingStarImageView.image = UIImage(named: "starOne")
        case 1.0..<1.5:
            self.reviewRatingStarImageView.image = UIImage(named: "starOneHalf")
        case 1.5..<2.0:
            self.reviewRatingStarImageView.image = UIImage(named: "starTwo")
        case 2.0..<2.5:
            self.reviewRatingStarImageView.image = UIImage(named: "starTwoHalf")
        case 2.5..<3.0:
            self.reviewRatingStarImageView.image = UIImage(named: "starThree")
        case 3.0..<3.5:
            self.reviewRatingStarImageView.image = UIImage(named: "starThreeHalf")
        case 3.5..<4.0:
            self.reviewRatingStarImageView.image = UIImage(named: "starFour")
        case 4.0..<4.5:
            self.reviewRatingStarImageView.image = UIImage(named: "starFourHalf")
        case 5.0:
            self.reviewRatingStarImageView.image = UIImage(named: "starFive")
        default :
            self.reviewRatingStarImageView.image = UIImage(named: "starZero")
        }
    }
    func setTableViewCellUI(){
        self.reviewUserNameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.reviewUserRatingLabel.font = UIFont.systemFont(ofSize: 10)
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
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
