//
//  MyReviewsMoreCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/13.
//

import UIKit

class MyReviewsMoreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myReviewBookThumbnailImageView: UIImageView!
    @IBOutlet weak var myReviewCreateAt: UILabel!
    @IBOutlet weak var myReviewBookTitleLabel: UILabel!
    @IBOutlet weak var myReviewBookAuthorLabel: UILabel!
    @IBOutlet weak var myReviewLikeImageView: UIImageView!
    @IBOutlet weak var myReviewLikeCntLabel: UILabel!
    @IBOutlet weak var myReviewDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: "lightGrayColor")?.cgColor
        self.layer.cornerRadius = 8.0
    }
    
}
