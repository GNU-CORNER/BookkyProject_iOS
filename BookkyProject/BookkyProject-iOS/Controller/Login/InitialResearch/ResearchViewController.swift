//
//  ResearchViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/11.
//

import UIKit

class ResearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tagsArray: [String] = ["React", "WEB", "JavaScript","Python","Machine Learning","C++","Java","AI","Angular","DB","Node.js","Android","Swift","Firebase","Network","C#","Unity","Flutter","Go"]

    @IBOutlet weak var tagsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tagsCollectionView.dataSource = self
        self.tagsCollectionView.delegate = self
        self.tagsCollectionView.allowsMultipleSelection = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagsCell", for: indexPath) as? TagsCollectionViewCell
        else {
            return UICollectionViewCell()
            
        }
        cell.tagNameLabel.text = tagsArray[indexPath.row]
        if cell.isSelected {
            cell.backgroundColor = UIColor(named: "primaryColor")
        } else {
            cell.backgroundColor = UIColor(named: "grayColor")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tagsCell", for: indexPath) as? TagsCollectionViewCell
        else {
            return
        }

        if cell.isSelected {
            print(cell.isSelected)
            self.tagsCollectionView.reloadData()
            cell.isSelected = false
        } else {
            self.tagsCollectionView.reloadData()
        }
        print(indexPath.row)
        print("그래서 바뀜?\(cell.isSelected)")
    }
}
