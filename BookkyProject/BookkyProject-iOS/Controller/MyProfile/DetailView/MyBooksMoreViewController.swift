//
//  MyBooksMoreViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/12.
//

import UIKit

class MyBooksMoreViewController: UIViewController {

    @IBOutlet weak var myBooksMoreCollectionView: UICollectionView!
    struct myBooksMoreModel {
        var image: UIImage
        var title: String
    }
    var myBooksMoreArray: [myBooksMoreModel] = [
        myBooksMoreModel(image: UIImage(named: "생각하는북키1")!, title: "생각하는북키1"),
        myBooksMoreModel(image: UIImage(named: "생각하는북키1")!, title: "생각하는북키1"),
        myBooksMoreModel(image: UIImage(named: "생각하는북키1")!, title: "생각하는북키1"),
        myBooksMoreModel(image: UIImage(named: "생각하는북키1")!, title: "생각하는북키1"),
        myBooksMoreModel(image: UIImage(named: "생각하는북키1")!, title: "생각하는북키1"),
        myBooksMoreModel(image: UIImage(named: "생각하는북키1")!, title: "생각하는북키1")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myBooksMoreCollectionView.delegate = self
        self.myBooksMoreCollectionView.dataSource = self
        setDefaultView()
    }
    
    private func setDefaultView() {
//        self.navigationController?.navigationBar.tintColor = UIColor(named: "Label Color")
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "관심도서 보기"
    }
    
    @objc func shareButtonTapped() {
        // nothing else ^^
    }
}

extension MyBooksMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myBooksMoreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBooksMoreCell", for: indexPath) as? MyBooksMoreCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.bookThumbnailImageView.image = myBooksMoreArray[indexPath.row].image
        cell.booksTitleLabel.text = myBooksMoreArray[indexPath.row].title
        return cell
    }
    
    
}
