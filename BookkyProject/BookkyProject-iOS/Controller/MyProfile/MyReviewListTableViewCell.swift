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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
