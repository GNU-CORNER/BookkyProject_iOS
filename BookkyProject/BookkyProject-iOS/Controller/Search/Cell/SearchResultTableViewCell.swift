//
//  SearchResultTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    var myTagsArray: [TagDatum] = []

    @IBOutlet weak var searchResultBookImageView: UIImageView!
    @IBOutlet weak var searchResultBookTitle: UILabel!
    @IBOutlet weak var searchResultBookAuthorLabel: UILabel!
    @IBOutlet weak var searchResultBookRateLabel: UILabel!
    @IBOutlet weak var searchResultBooksTagCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.searchResultBooksTagCollectionView.dataSource = self
        self.searchResultBooksTagCollectionView.delegate = self
        
        self.searchResultBooksTagCollectionView.register(UINib(nibName: "SearchTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyTagCollectionViewCellid")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setBookTags(tagArray: [TagDatum]) {
        self.myTagsArray = tagArray
        DispatchQueue.main.async {
            self.searchResultBooksTagCollectionView.reloadData()
        }
    }
    
}

extension SearchResultTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myTagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let tagCell: MyTagsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTagCollectionViewCellid", for: indexPath) as? MyTagsCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        tagCell.tagNameLabel.text = "# \(myTagsArray[indexPath.row].tag)"
        return tagCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let tagCell: MyTagsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTagCollectionViewCellid", for: indexPath) as? MyTagsCollectionViewCell
        else {
            return .zero
        }
        tagCell.tagNameLabel.text = "# \(myTagsArray[indexPath.row].tag)"
        tagCell.tagNameLabel.sizeToFit()
        let cellWidth = tagCell.tagNameLabel.frame.width + 16
        return CGSize(width: cellWidth, height: 25)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
}
