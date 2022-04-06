//
//  BoardTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/06.
//

import UIKit

class BoardTableViewCell: UITableViewCell {

    @IBOutlet weak var tableViewCell: UIView!
    @IBOutlet weak var boardTableViewCellStackView: UIStackView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var subtittleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.subtittleLabel.numberOfLines = 2
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
