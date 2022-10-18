//
//  MyBooksMoreViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/12.
//

import UIKit

class MyBooksMoreViewController: UIViewController {

    @IBOutlet weak var myBooksMoreCollectionView: UICollectionView!
    
    var myBooksMoreArray: [FavoriteBookList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myBooksMoreCollectionView.delegate = self
        self.myBooksMoreCollectionView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor(named: "BlackOrWhite")
        setDefaultView()
        requestFavoriteBook()
    }
    
    private func setDefaultView() {
        
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "관심도서 보기"
    }
    
    private func requestFavoriteBook() {
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("관심도서: 사용자 이메일을 불러올 수 없음.")
            return
        }
        guard let accessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("관심도서: 토큰을 불러올 수 없음.")
            return
        }
        // 실제 API 호출 함수 호출!
        MyProfileAPI.shared.favoriteBooks(accessToken: accessToken) { (success, data, statuscode) in
            guard let favoriteBookData = data as? MyprofileModel else { return }
            if success {
                self.myBooksMoreArray = (favoriteBookData.result?.favoriteBookList)!
                self.myBooksMoreArray = self.myBooksMoreArray.reversed()
                DispatchQueue.main.async {
                    self.myBooksMoreCollectionView.reloadData()
                }
                
            } else {
                print("")
            }
        }
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
        if let bookThumbnailURL = URL(string: myBooksMoreArray[indexPath.row].thumbnailImage) {
            cell.bookThumbnailImageView.load(url: bookThumbnailURL)
        }
        cell.booksTitleLabel.text = myBooksMoreArray[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        guard let BookDetailVC = homeStoryboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController else {
            return
        }
        BookDetailVC.BID = self.myBooksMoreArray[indexPath.row].tbid
        self.navigationController?.pushViewController(BookDetailVC, animated: true)
    }
}
