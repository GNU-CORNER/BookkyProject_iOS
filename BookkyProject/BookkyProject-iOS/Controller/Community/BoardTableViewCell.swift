//
//  BoardTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/06.
//

import UIKit

class BoardTableViewCell: UITableViewCell {
    @IBOutlet weak var tableViewCell: UIView!
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var subtittleLabel: UILabel!
    
    @IBOutlet weak var likeThatImageView: UIImageView!
    @IBOutlet weak var likeThatCountLabel: UILabel!
    
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.likeThatImageView.image = UIImage(named: "likeThat")
        self.commentImageView.image = UIImage(named: "comment")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
