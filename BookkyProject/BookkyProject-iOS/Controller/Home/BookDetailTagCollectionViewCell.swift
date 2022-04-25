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
        self.tagNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        self.tagNameLabel.textColor = UIColor(named: "primaryColor")
        self.tagNameLabel.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        self.tagNameLabel.clipsToBounds = true  //cornerRadius를 주기 위함
        self.tagNameLabel.layer.borderWidth = 1
        self.tagNameLabel.layer.cornerRadius = 10
        self.tagNameLabel.layer.borderColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1).cgColor
    }
    
}
