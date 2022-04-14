//
//  BookDetailTagCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/13.
//

import UIKit

class BookDetailTagCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet weak var tagNameLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tagNameLabel.layer.borderWidth = 1
        self.tagNameLabel.sizeToFit()
        self.tagNameLabel.font = UIFont.systemFont(ofSize: 13)
    }
   
}
