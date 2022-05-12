//
//  ResearchViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/11.
//

import UIKit

class ResearchViewController: UIViewController {
    
    var tagsArray: [String] = ["React", "WEB", "JavaScript","Python","Machine Learning","C++","Java","AI","Angular","DB","Node.js","Android","Swift","Firebase","Network","C#","Unity","Flutter","Go"]

    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    var selectedTagsCnt: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tagsCollectionView.dataSource = self
        self.tagsCollectionView.delegate = self
        setDefaultView()
    }
    
    private func setDefaultView() {
        self.submitButton.layer.cornerRadius = 8.0
        self.tagsCollectionView.allowsMultipleSelection = true
        self.submitButton.setTitle("제출", for: .normal)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
}

extension ResearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
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
            cell.layer.backgroundColor = UIColor(named: "primaryColor")?.cgColor
            cell.tagNameLabel.textColor = .white
        } else {
            cell.layer.backgroundColor = UIColor(named: "lightGrayColor")?.cgColor
            cell.tagNameLabel.textColor = .black
        }

        cell.layer.cornerRadius = 80 / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagsCollectionViewCell else { return }
        cell.layer.backgroundColor = UIColor(named: "primaryColor")?.cgColor
        cell.tagNameLabel.textColor = .white

        self.selectedTagsCnt += 1
        self.submitButton.setTitle("제출 (\(self.selectedTagsCnt)개 선택)", for: .normal)
        print(cell.isSelected)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagsCollectionViewCell
        else {
            return
        }
        cell.layer.backgroundColor = UIColor(named: "lightGrayColor")?.cgColor
        cell.tagNameLabel.textColor = .black
    
        self.selectedTagsCnt -= 1
        self.submitButton.setTitle("제출 (\(self.selectedTagsCnt)개 선택)", for: .normal)
        print(cell.isSelected)
    }
    
}
