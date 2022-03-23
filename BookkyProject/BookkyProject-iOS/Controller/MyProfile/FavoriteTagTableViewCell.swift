//
//  FavoriteTagTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/17.
//

import UIKit

class FavoriteTagTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionHeaderLabel: UILabel!
    @IBOutlet weak var favoriteTagsCollectionView: UICollectionView!
    
    let tagLabelArray = ["React", "JavaScript", "iOS", "Swift", "Django"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 24)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.favoriteTagsCollectionView?.collectionViewLayout = flowLayout
        self.favoriteTagsCollectionView?.showsHorizontalScrollIndicator = false
        
        self.favoriteTagsCollectionView?.dataSource = self
        self.favoriteTagsCollectionView?.delegate = self
        
        let cellNib = UINib(nibName: "FavoriteTagsCollectionViewCell", bundle: nil)
        self.favoriteTagsCollectionView?.register(cellNib, forCellWithReuseIdentifier: "TagCellid")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FavoriteTagTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagLabelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteTagsCollectionView.dequeueReusableCell(withReuseIdentifier: "TagCellid", for: indexPath) as! FavoriteTagsCollectionViewCell
        cell.tagLabel?.text = "# \(tagLabelArray[indexPath.row])"
//        print(tagLabelArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

