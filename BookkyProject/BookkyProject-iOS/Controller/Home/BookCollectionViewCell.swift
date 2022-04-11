//
//  BookCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    func setBookData(model: BookData){
        
        bookNameLabel.text = model.TITLE
        let url = URL(string: "\(model.thumbnailImage)")
        let data = try! Data(contentsOf: url!)
        bookImageView.image = UIImage(data: data)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
}
