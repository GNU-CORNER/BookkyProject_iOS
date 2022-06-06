//
//  SearchDefaultTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SearchDefaultTableViewCell: UITableViewCell {

    @IBOutlet weak var magnifyglassImage: UIImageView!
    @IBOutlet weak var recentSearchKeywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
