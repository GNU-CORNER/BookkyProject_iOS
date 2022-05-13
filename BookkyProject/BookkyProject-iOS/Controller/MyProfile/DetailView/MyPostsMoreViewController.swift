//
//  MyPostsMoreViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/12.
//

import UIKit

class MyPostsMoreViewController: UIViewController {

    @IBOutlet weak var myPostsMoreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPostsMoreCollectionView.delegate = self
        self.myPostsMoreCollectionView.dataSource = self
        setDefaultView()
        registerMyPostsCellNib()
    }
    
    private func setDefaultView() {
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Label Color")
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "내 글 보기"
    }
    
    private func registerMyPostsCellNib() {
        let nibName = UINib(nibName: "MyPostsCollectionViewCell", bundle: nil)
        myPostsMoreCollectionView.register(nibName, forCellWithReuseIdentifier: "MyPostsCollectionViewCell")
    }
    
    @objc func searchButtonTapped() {
        
    }
}

extension MyPostsMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPostsCollectionViewCell", for: indexPath) as? MyPostCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.myPostsTitleLabel.text = "안녕"
        cell.myPostsDescriptionLabel.text = "안녕 본문"
        cell.myPostsLikeLabel.text = "2"
        cell.myPostsCommentsLabel.text = "2"
        cell.myPostsLikeImageView.image = UIImage(named: "likeThat")
        cell.myPostsCommentsImageView.image = UIImage(named: "comment")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width - 40
        return CGSize(width: width, height: 72)
    }
    
}
