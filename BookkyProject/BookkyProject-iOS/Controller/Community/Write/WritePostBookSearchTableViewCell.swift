//
//  WritePostBookSearchTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class WritePostBookSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorNPublisher: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setTableViewCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setTableViewCellUI(){
        self.bookNameLabel.font = UIFont.systemFont(ofSize: 18)
        self.bookAuthorNPublisher.font = UIFont.systemFont(ofSize: 14)
    }
}

