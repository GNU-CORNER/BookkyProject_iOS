//
//  MyReviewsCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/04.
//

import UIKit

class MyPostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myPostsTitleLabel: UILabel!
    @IBOutlet weak var myPostsLikeLabel: UILabel!
    @IBOutlet weak var myPostsLikeImageView: UIImageView!
    @IBOutlet weak var myPostsCommentsLabel: UILabel!
    @IBOutlet weak var myPostsCommentsImageView: UIImageView!
    @IBOutlet weak var myPostsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
        self.myPostsDescriptionLabel?.textColor = UIColor(named: "grayColor")
        self.myPostsLikeLabel?.textAlignment = .left
        self.myPostsLikeLabel?.textColor = UIColor(named: "PrimaryOrangeColor")
        self.myPostsLikeImageView?.image = UIImage(named: "likeThat")
        self.myPostsCommentsLabel?.textAlignment = .left
        self.myPostsCommentsLabel?.textColor = UIColor(named: "PrimaryBlueColor")
        self.myPostsCommentsImageView?.image = UIImage(named: "comment")
    }
}
