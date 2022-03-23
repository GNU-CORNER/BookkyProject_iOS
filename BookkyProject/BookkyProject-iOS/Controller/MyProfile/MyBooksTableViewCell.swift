//
//  MyBooksTableViewCell.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/19.
//

import UIKit

class MyBooksTableViewCell: UITableViewCell {

    @IBOutlet weak var myBooksHeader: UILabel!
    @IBOutlet weak var myBooksMoreButton: UIButton!
    @IBOutlet weak var myBooksCollectionView: UICollectionView!
    
    let myBooksName = ["DeepLearning", "혼자 공부하는 머신러닝 + 딥러닝", "개를 다루는 기술", "React", "파리의 택시 운전사"]
    let myBooksImage: [UIImage?] = [
        UIImage(named: "DeepLearning"),
        UIImage(named: "리액트를다루는기술"),
        UIImage(named: "DeepLearning"),
        UIImage(named: "리액트를다루는기술"),
        UIImage(named: "DeepLearning")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 95, height: 130)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.myBooksCollectionView.collectionViewLayout = flowLayout
        self.myBooksCollectionView.showsHorizontalScrollIndicator = false
        
        self.myBooksCollectionView.dataSource = self
        self.myBooksCollectionView.delegate = self
        
        let cellNib = UINib(nibName: "MyBooksCollectionViewCell", bundle: nil)
        self.myBooksCollectionView.register(cellNib, forCellWithReuseIdentifier: "MyBooksCollectionViewCellid")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MyBooksTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myBooksName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myBooksCollectionView.dequeueReusableCell(withReuseIdentifier: "MyBooksCollectionViewCellid", for: indexPath) as! MyBooksCollectionViewCell
        cell.myBookImage?.image = myBooksImage[indexPath.row]
        cell.myBookLabel?.text = myBooksName[indexPath.row]
        return cell
    }
}
