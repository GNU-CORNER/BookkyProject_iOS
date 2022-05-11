//
//  TagViewCollectionViewCell.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/01.
//

import UIKit

class TagViewCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    func setTagBookList(model: TagBookData){
        bookNameLabel.text = model.TITLE
     
        let url = URL(string: "\(model.thumbnailImage)")
        let data = try! Data(contentsOf: url!)
        bookImageView.image = UIImage(data: data)
    }
    private func setCollectionViewCell() {
      
        let flowLayout = UICollectionViewFlowLayout()
       
        flowLayout.itemSize = CGSize(width: 80, height: 120)  //cellsize
        flowLayout.minimumLineSpacing = 1.0
        bookNameLabel.numberOfLines = 2 
        bookNameLabel.font = UIFont.systemFont(ofSize: 13)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCollectionViewCell()
   
    }
}
