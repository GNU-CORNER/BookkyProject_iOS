//
//  SearchNoResultTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/05.
//

import UIKit

class SearchNoResultTableViewCell: UITableViewCell {

    @IBOutlet weak var noResultView: UIView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        noResultView.layer.cornerRadius = 8.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
