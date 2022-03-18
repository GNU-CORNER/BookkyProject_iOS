//
//  FavoriteTagsCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/17.
//

import UIKit

class FavoriteTagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.backgroundColor = CGColor(red: 1, green: 1, blue: 0, alpha: 0)
        self.layer.cornerRadius = 8
    }

}
