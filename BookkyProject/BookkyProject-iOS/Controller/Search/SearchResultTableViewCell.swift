//
//  SearchResultTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    var myTagsArray: [UserTagList] = [
        UserTagList(tag: "iOS", tmid: 0),
        UserTagList(tag: "Swift", tmid: 0),
        UserTagList(tag: "Xcode", tmid: 0),
        UserTagList(tag: "UIUX", tmid: 0),
        UserTagList(tag: "Python", tmid: 0),
        UserTagList(tag: "Django", tmid: 0),
        UserTagList(tag: "iPhone", tmid: 0)
    ]

    @IBOutlet weak var searchResultBookImageView: UIImageView!
    @IBOutlet weak var searchResultBookTitle: UILabel!
    @IBOutlet weak var searchResultBookAuthorLabel: UILabel!
    @IBOutlet weak var searchResultBookRateLabel: UILabel!
    @IBOutlet weak var searchResultBooksTagCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        flowLayout.itemSize = CGSize(width: 150, height: 180)
//        flowLayout.minimumLineSpacing = 2.0
//        flowLayout.minimumInteritemSpacing = 5.0
//        self.searchResultBooksTagCollectionView.collectionViewLayout = flowLayout
        self.searchResultBooksTagCollectionView.showsHorizontalScrollIndicator = false
        
        self.searchResultBooksTagCollectionView.dataSource = self
        self.searchResultBooksTagCollectionView.delegate = self
        
        self.searchResultBooksTagCollectionView.register(UINib(nibName: "SearchTagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyTagCollectionViewCellid")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SearchResultTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
        tagCell.tagNameLabel.sizeToFit()
//        let width = tagCell.tagNameLabel.frame.width + 30
        return CGSize(width: 100, height: 25)
    }
    
}
