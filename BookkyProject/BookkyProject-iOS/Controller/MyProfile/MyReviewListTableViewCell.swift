//
//  MyReviewListTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/22.
//

import UIKit

class MyReviewListTableViewCell: UITableViewCell {

    @IBOutlet weak var myReviewBookThumbnail: UIImageView!
    @IBOutlet weak var myReviewTitle: UILabel!
    @IBOutlet weak var myReviewBookAuthorAndPublisher: UILabel!
    @IBOutlet weak var myReviewDescription: UILabel!
    @IBOutlet weak var bookRateStar: UIImageView!
    @IBOutlet weak var bookRateNumber: UILabel!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var likeNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8
        /// 테마 색상으로 변경!
        self.layer.borderColor = CGColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.00)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
