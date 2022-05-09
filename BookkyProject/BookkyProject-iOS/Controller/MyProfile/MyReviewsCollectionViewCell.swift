//
//  MyPostsCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/04.
//

import UIKit

class MyReviewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myReviewsBookImageView: UIImageView!
    @IBOutlet weak var myReviewsBookTitleLabel: UILabel!
    @IBOutlet weak var myReviewsBookDescriptionLabel: UILabel!
    @IBOutlet weak var myReviewsBookAuthorLabel: UILabel!
    @IBOutlet weak var myReviewsBookRate: UIImageView!
    @IBOutlet weak var myReviewsLikeLabel: UILabel!
    @IBOutlet weak var myReviewsLikeImageView: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "F9F9F9")?.cgColor
        self.myReviewsBookDescriptionLabel.textColor = UIColor(named: "grayColor")
        self.myReviewsLikeLabel.textAlignment = .left
        self.myReviewsLikeLabel.textColor = UIColor(named: "PrimaryOrangeColor")
        self.myReviewsLikeImageView.image = UIImage(named: "likeThat")
    }
}
