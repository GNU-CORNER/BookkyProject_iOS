//
//  MyPostsMoreViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/12.
//

import UIKit

class MyPostsMoreViewController: UIViewController {

    @IBOutlet weak var myPostsMoreCollectionView: UICollectionView!
    var myPostsMoreArray: [UserPostList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPostsMoreCollectionView.delegate = self
        self.myPostsMoreCollectionView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor(named: "BlackOrWhite")
        setDefaultView()
        registerMyPostsCellNib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("My Reviews: 사용자 이메일을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        guard let accessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("My Reivews: 사용자 토큰을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        self.requestMyPosts(accessToken: accessToken)
    }
    
    private func requestMyPosts(accessToken: String) {
        MyProfileAPI.shared.myPosts(accessToken: accessToken) { (success, data, statuscode) in
            if success {
                guard let myPostsData = data as? MyprofileModel else {
                    // 예외처리
                    return
                }
                if let myPostsList = myPostsData.result?.communityList {
                    self.myPostsMoreArray = myPostsList
                }
                DispatchQueue.main.async {
                    self.myPostsMoreCollectionView.reloadData()
                }
            } else {

            }
        }
    }
    
    private func setDefaultView() {
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
        return myPostsMoreArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPostsCollectionViewCell", for: indexPath) as? MyPostCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.myPostsTitleLabel.text = myPostsMoreArray[indexPath.row].title
        cell.myPostsDescriptionLabel.text = myPostsMoreArray[indexPath.row].contents
        cell.myPostsLikeLabel.text = String(myPostsMoreArray[indexPath.row].likeCnt)
        cell.myPostsCommentsLabel.text = String(myPostsMoreArray[indexPath.row].commentCnt)
        cell.myPostsLikeImageView.image = UIImage(named: "likeThat")
        cell.myPostsCommentsImageView.image = UIImage(named: "comment")
        cell.layer.cornerRadius = 0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width
        return CGSize(width: width, height: 72)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let CommunityStoryboard: UIStoryboard = UIStoryboard(name: "Community", bundle: nil)
        guard let BoardTextDetailVC = CommunityStoryboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BoardTextDetailViewController else {
            return
        }
        BoardTextDetailVC.PID = myPostsMoreArray[indexPath.row].pid
        BoardTextDetailVC.boardTypeNumber = myPostsMoreArray[indexPath.row].communityType
        //?
        BoardTextDetailVC.previousBoardNumber = 0
        self.navigationController?.pushViewController(BoardTextDetailVC, animated: true)
        
    }
    
}
