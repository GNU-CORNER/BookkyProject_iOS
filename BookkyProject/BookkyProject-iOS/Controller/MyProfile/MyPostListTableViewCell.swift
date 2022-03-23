//
//  MyPostListTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/22.
//

import UIKit

class MyPostListTableViewCell: UITableViewCell {

    @IBOutlet weak var myPostTitle: UILabel!
    @IBOutlet weak var myPostDescription: UILabel!
    @IBOutlet weak var likeIcon: UIImageView!
    @IBOutlet weak var likeNumber: UILabel!
    @IBOutlet weak var commentIcon: UIImageView!
    @IBOutlet weak var commentNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
