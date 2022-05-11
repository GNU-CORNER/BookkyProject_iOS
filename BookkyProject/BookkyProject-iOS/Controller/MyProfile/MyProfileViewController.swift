//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    var myTagsArray = ["iOS", "Swift", "Xcode", "UIUX", "Python", "Django", "iPhone"]
    var myBooksArray: [FavoriteBookList] = [
        FavoriteBookList(bid: 0, title: "책제목 테스트입니다1", author: "", thumbnailImage: "", rating: 0),
        FavoriteBookList(bid: 0, title: "책제목 테스트입니다2", author: "", thumbnailImage: "", rating: 0),
        FavoriteBookList(bid: 0, title: "책제목 테스트입니다3", author: "", thumbnailImage: "", rating: 0),
        FavoriteBookList(bid: 0, title: "책제목 테스트입니다4", author: "", thumbnailImage: "", rating: 0),
        FavoriteBookList(bid: 0, title: "책제목 테스트입니다5", author: "", thumbnailImage: "", rating: 0)
    ]
    var myPostArray: [UserPostList] = [
        UserPostList(title: "리뷰리뷰립류테스트1", contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~", communityType: 0, pid: 0, commentCnt: 0, likeCnt: 0),
        UserPostList(title: "립뷰뷰븁뷰뷰테스트2", contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~", communityType: 0, pid: 0, commentCnt: 0, likeCnt: 0)
    ]
    var myReviewsArray: [UserReviewList] = [
        UserReviewList(rid: 0, bid: 0, uid: 0, contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..", views: 0, createAt: "", rating: 0, likeCnt: 0, isLiked: false, isAccessible: false, nickname: "", author: "", bookTitle: "리뷰리뷰립류테스트1", thumbnail: ""),
        UserReviewList(rid: 0, bid: 0, uid: 0, contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..", views: 0, createAt: "", rating: 0, likeCnt: 0, isLiked: false, isAccessible: false, nickname: "", author: "", bookTitle: "립뷰뷰븁뷰뷰테스트2", thumbnail: "")
    ]
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myTagsCollectionView: UICollectionView!
    @IBOutlet weak var myBooksCollectionView: UICollectionView!
    @IBOutlet weak var myPostCollectionView: UICollectionView!
    @IBOutlet weak var myReviewsCollectionView: UICollectionView!
    
    var userName = "비회원"
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultMyProfileView()
        setCollectionViewDelegate()
        setCollectionViewDataSource()
        registerNibCollectionViewCell()
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        // - [x] UserDefaults에 저장되어 있는 사용자 이메일 가져오기
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("Launch: 사용자 이메일을 불러올 수 없음.")
//            redirectLoginView()
            RedirectView.redirectLoginView(previousView: self)
            return
        }

        // - [x] 사용자 이메일로 KeyChain에 저장되어 있는 AT, RT를 가져오기
        guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("Launch: 토큰을 불러올 수 없음.")
//            redirectLoginView()
            RedirectView.redirectLoginView(previousView: self)
            return
        }
        print("view will appear")
        self.requestMyprofile(accessToken: previousAccessToken)
        
                
    }
    
    // MARK: - Request MyProfile
    private func requestMyprofile(accessToken: String) {
        print("request MyProfile: 통신 요청")
        MyProfileAPI.shared.myprofile(accessToken: accessToken) { (success, data, statuscode) in
            guard let myprofileData = data as? MyprofileModel else { return }
            if success {
                print("잘 되었따.")
                self.myTagsArray = (myprofileData.result?.userData.userTagList)!
                self.myBooksArray = (myprofileData.result?.favoriteBookList)!
                self.myPostArray = (myprofileData.result?.userPostList)!
                self.myReviewsArray = (myprofileData.result?.userReviewList)!
                DispatchQueue.main.async {
                    self.setUserNameLabel((myprofileData.result?.userData.nickname)!)
                    self.myTagsCollectionView.reloadData()
                    self.myBooksCollectionView.reloadData()
                    self.myPostCollectionView.reloadData()
                    self.myReviewsCollectionView.reloadData()
                }
                
            } else {
                print("request MyProfile: false")
                if statuscode == 403 {
                    // 새로 AT 갱신할 것.
                    print(statuscode)
                    if let errorMessage = myprofileData.errorMessage {
                        print("request MyProfile false의 이유: \(errorMessage)")
                    }

                    guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
                        print("Launch: 사용자 이메일을 불러올 수 없음.")
                        return
                    }
                    guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
                          let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
                        print("Launch: 토큰을 불러올 수 없음.")
                        return
                    }
                    print("갱신요청")
                    Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
                        print(success)
                        guard let tokens = data as? RefreshModel else { return }
                        if success {
                            if let newAccessToken = tokens.result?.accessToken {
                                if !KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                                    print("Launch: 새로운 토큰 제대로 저장이 안되었어요~~~~")
                                }
                                self.requestMyprofile(accessToken: previousAccessToken)
                            }
                        } else {
                            if statuscode == 400 {
                                // 유효한 토큰입니다.
                                print(tokens.errorMessage)
                            } else if statuscode == 403 {
                                // 기간이 지난 토큰입니다.
                                // 로그인 화면 리다이렉트
//                                self.redirectLoginView()
                                RedirectView.redirectLoginView(previousView: self)
                            }
                        }
                    }
                    
                } else {
                    print(statuscode)
                    if let errorMessage = myprofileData.errorMessage {
                        print("request MyProfile false의 이유: \(errorMessage)")
                    }
                }
            }
        }
    }
    
    // MARK: - Set Up View func.
    private func setUserImageViewCornerRadius() {
        userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
    }
    
    private func setDefaultUserImage() {
        userImageView.image = UIImage(named: "북키프사")
    }
    
    private func setUserNameLabel(_ userName:String) {
        userNameLabel.text = userName + "님, 반가워요!"
    }
    
    private func setDefaultMyProfileView() {
        setUserImageViewCornerRadius()
        setDefaultUserImage()
        setUserNameLabel(userName)
        
    }
    
    private func registerNibCollectionViewCell() {
        
        self.myPostCollectionView.register(UINib(nibName: "MyPostsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyPostsCollectionViewCell")
        
        self.myReviewsCollectionView.register(UINib(nibName: "MyReviewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyReviewsCollectionViewCell")
    }
    
    // MARK: - Redirect Login View
    // 임시, 새로 시나리오 짤 것...
//    func redirectLoginView() {
//        //스토리보드의 파일 찾기
//        let storyboard: UIStoryboard? = UIStoryboard(name: "Login", bundle: Bundle.main)
//
//        // 스토리보드에서 지정해준 ViewController의 ID
//        DispatchQueue.main.async {
//            guard let vc = storyboard?.instantiateViewController(identifier: "LoginNavigation") else {
//                return
//            }
//            // 화면 전환방식 선택 (default : .modal)
//            vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//
//
//            // 화면 전환!
//            self.present(vc, animated: true)
//        }
//    }

    @IBAction func loginTestButton(_ sender: Any) {
//        redirectLoginView()
        RedirectView.redirectLoginView(previousView: self)
    }

}


// MARK: - UICollectionView Extension
extension MyProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.myTagsCollectionView {
            return myTagsArray.count
        } else if collectionView == self.myBooksCollectionView {
            return myBooksArray.count
        } else if collectionView == self.myPostCollectionView {
            return myPostArray.count
        } else {
            return myReviewsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.myTagsCollectionView {
            guard let myTagsCell: MyTagsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTagsCell", for: indexPath) as? MyTagsCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            myTagsCell.tagNameLabel.text = "#\(myTagsArray[indexPath.row])"
            return myTagsCell
            
        } else if collectionView == self.myBooksCollectionView {
            guard let myBooksCell: MyBooksCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyBooksCell", for: indexPath) as? MyBooksCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            if let thumbnailUrl = URL(string: myBooksArray[indexPath.row].thumbnailImage) {
                do {
                    let thumbnailData = try Data(contentsOf: thumbnailUrl)
                    myBooksCell.myBooksImageView.image = UIImage(data: thumbnailData)
                } catch {
                    print(error)
                }
            }
            myBooksCell.myBooksLabel.text = "\(myBooksArray[indexPath.row].title)"
            return myBooksCell
            
        } else if collectionView == self.myPostCollectionView {
            guard let myPostCell: MyPostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPostsCollectionViewCell", for: indexPath) as? MyPostCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            myPostCell.myPostsTitleLabel.text = myPostArray[indexPath.row].title
            myPostCell.myPostsDescriptionLabel.text = myPostArray[indexPath.row].contents
            myPostCell.myPostsLikeLabel.text = String(myPostArray[indexPath.row].likeCnt)
            myPostCell.myPostsCommentsLabel.text = String(myPostArray[indexPath.row].commentCnt)
            return myPostCell
            
        } else {
            guard let myReviewsCell: MyReviewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyReviewsCollectionViewCell", for: indexPath) as? MyReviewsCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            myReviewsCell.myReviewsBookTitleLabel.text = myReviewsArray[indexPath.row].bookTitle
            myReviewsCell.myReviewsBookDescriptionLabel.text = myReviewsArray[indexPath.row].contents
            myReviewsCell.myReviewsBookAuthorLabel.text = myReviewsArray[indexPath.row].author
            if let thumbnailUrl = URL(string: myReviewsArray[indexPath.row].thumbnail) {
                do {
                    let thumbnailData = try Data(contentsOf: thumbnailUrl)
                    myReviewsCell.myReviewsBookImageView.image = UIImage(data: thumbnailData)
                } catch {
                    print(error)
                }
            }
            myReviewsCell.myReviewsLikeLabel.text = String(myReviewsArray[indexPath.row].likeCnt)

            return myReviewsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if collectionView == self.myTagsCollectionView {
            return CGSize(width: 100, height: 25)
        }
        if collectionView == self.myBooksCollectionView {
            return CGSize(width: 100, height: 125)
        }
        if collectionView == self.myPostCollectionView {
            let width = collectionView.frame.width - 40
            return CGSize(width: width, height: 72)
        }
        if collectionView == self.myReviewsCollectionView {
            let width = collectionView.frame.width - 40
            return CGSize(width: width, height: 72)
        }
        return CGSize()
    }
    
    
    func setCollectionViewDelegate() {
        myTagsCollectionView.delegate = self
        myBooksCollectionView.delegate = self
        myPostCollectionView.delegate = self
        myReviewsCollectionView.delegate = self
    }
    func setCollectionViewDataSource() {
        myTagsCollectionView.dataSource = self
        myBooksCollectionView.dataSource = self
        myPostCollectionView.dataSource = self
        myReviewsCollectionView.dataSource = self
    }
        
}
