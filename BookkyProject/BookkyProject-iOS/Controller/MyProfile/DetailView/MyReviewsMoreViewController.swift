//
//  MyReviewsMoreViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/12.
//

import UIKit

class MyReviewsMoreViewController: UIViewController {

    @IBOutlet weak var myReviewsMoreCollectionView: UICollectionView!
    var myReviewsMoreArray: [UserReviewList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myReviewsMoreCollectionView.delegate = self
        self.myReviewsMoreCollectionView.dataSource = self
        setDefaultView()
        registerMyPostsCellNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("My Reviews: 사용자 이메일을 불러올 수 없음.")
            RedirectView.redirectLoginView(previousView: self)
            return
        }
        guard let accessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("My Reivews: 사용자 토큰을 불러올 수 없음.")
            RedirectView.redirectLoginView(previousView: self)
            return
        }
        self.requestMyReivews(accessToken: accessToken)
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

    private func requestMyReivews(accessToken: String) {
        MyProfileAPI.shared.myReviews(accessToken: accessToken) { (success, data, statuscode) in
            if success {
                guard let myReviewData = data as? MyprofileModel else { return }
                if let myReviewsList = myReviewData.result?.reviewList {
                    self.myReviewsMoreArray = myReviewsList
                }
                DispatchQueue.main.async {
                    self.myReviewsMoreCollectionView.reloadData()
                }
            } else {
                print("My Reviews: 통신 실패... 뭔가 안되는게 있듬. \(statuscode)")
            }
        }
    }

}
extension MyReviewsMoreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myReviewsMoreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyReviewsMoreCell", for: indexPath) as? MyReviewsMoreCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        if let bookThumbnailURL = URL(string: myReviewsMoreArray[indexPath.row].thumbnail) {
            do {
                let thumbnailData = try Data(contentsOf: bookThumbnailURL)
                cell.myReviewBookThumbnailImageView.image = UIImage(data: thumbnailData)
            } catch {
                print(error)
            }
        }
        cell.myReviewBookTitleLabel.text = myReviewsMoreArray[indexPath.row].bookTitle
        cell.myReviewBookAuthorLabel.text = myReviewsMoreArray[indexPath.row].author
        cell.myReviewDescriptionLabel.text = myReviewsMoreArray[indexPath.row].contents
        cell.myReviewLikeImageView.image = UIImage(named: "likeThat")
        cell.myReviewLikeCntLabel.text = String(myReviewsMoreArray[indexPath.row].likeCnt)
        cell.myReviewCreateAt.text = myReviewsMoreArray[indexPath.row].createAt
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width - 20
        return CGSize(width: width, height: 72)
    }
    
}
