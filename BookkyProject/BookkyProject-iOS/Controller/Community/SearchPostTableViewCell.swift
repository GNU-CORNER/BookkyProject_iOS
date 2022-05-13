//
//  SearchPostTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class SearchPostTableViewCell: UITableViewCell {

    @IBOutlet weak var SearchTableViewCell: SearchPostTableViewCell!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postContentsLabel: UILabel!
    @IBOutlet weak var likeThatImage: UIImageView!
    @IBOutlet weak var likThatCountLabel: UILabel!
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setBoardTableViewCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setBoardTableViewCellUI(){
      
        self.likThatCountLabel?.textColor = UIColor(named: "PrimaryOrangeColor")
        self.commentLabel?.textColor = UIColor(named: "PrimaryBlueColor")
    }
}
