//
//  MyReviewsMoreViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/12.
//

import UIKit

class MyReviewsMoreViewController: UIViewController {

    @IBOutlet weak var myReviewsMoreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myReviewsMoreCollectionView.delegate = self
        self.myReviewsMoreCollectionView.dataSource = self
        setDefaultView()
        registerMyPostsCellNib()
    }
    
    private func setDefaultView() {
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Label Color")
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "내 후기 보기"
    }
    
    private func registerMyPostsCellNib() {
        let nibName = UINib(nibName: "MyReviewsMoreCollectionViewCell", bundle: nil)
        myReviewsMoreCollectionView.register(nibName, forCellWithReuseIdentifier: "MyReviewsMoreCell")
    }


}
extension MyReviewsMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyReviewsMoreCell", for: indexPath) as? MyReviewsMoreCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.myReviewBookThumbnailImageView.image = UIImage(named: "로긴북키2-1")
        cell.myReviewBookTitleLabel.text = "테스트 제목"
        cell.myReviewBookAuthorLabel.text = "테스트 저자"
        cell.myReviewDescriptionLabel.text = "테스트 본문테스트 본문테스트 본문테스트 본문테스트 본문테스트 본문"
        cell.myReviewLikeImageView.image = UIImage(named: "likeThat")
        cell.myReviewLikeCntLabel.text = "56"
        cell.myReviewCreateAt.text = "2022-05-13"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width - 20
        return CGSize(width: width, height: 72)
    }
    
}
