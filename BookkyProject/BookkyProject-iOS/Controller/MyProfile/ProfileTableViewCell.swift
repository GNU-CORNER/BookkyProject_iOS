//
//  TableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/15.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameUpdateButton: UIButton!
    @IBOutlet weak var myTagsHeader: UILabel!
    @IBOutlet weak var myTagsResetButton: UIButton!
    @IBOutlet weak var myTagsCollectionView: UICollectionView!
    
    let tagList: [String] = ["iOS", "Swift", "DataBase", "Python", "Docker"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // thumb nail corner round
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2.0
        
        self.myTagsCollectionView.delegate = self
        self.myTagsCollectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.minimumInteritemSpacing = 5.0
//        flowLayout.itemSize = CGSize(width: 100, height: 30)
        flowLayout.sectionInset.left = 20
        flowLayout.sectionInset.right = 20
        self.myTagsCollectionView.collectionViewLayout = flowLayout
        self.myTagsCollectionView.showsHorizontalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}


extension ProfileTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myTagsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyTagCollectionViewCell", for: indexPath) as! MyTagCollectionViewCell
        cell.layer.cornerRadius = 8
        cell.myTagLabel?.text = "# " + tagList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = myTagsCollectionView.dequeueReusableCell(withReuseIdentifier: "MyTagCollectionViewCell", for: indexPath) as? MyTagCollectionViewCell else { return .zero }
        cell.myTagLabel.text = tagList[indexPath.row]
        // ✅ sizeToFit() : 텍스트에 맞게 사이즈가 조절
        cell.myTagLabel.sizeToFit()
        // ✅ cellWidth = 글자수에 맞는 UILabel 의 width + 20(여백)
        let cellWidth = cell.myTagLabel.frame.width + 28

        return CGSize(width: cellWidth, height: 25)
    }
    
}
