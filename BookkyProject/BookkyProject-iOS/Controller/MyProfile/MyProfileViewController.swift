//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    var myTagsArray: [UserTagList] = [
        UserTagList(tag: "iOS", tmid: 0)/*,
        UserTagList(tag: "Swift", tmid: 0),
        UserTagList(tag: "Xcode", tmid: 0),
        UserTagList(tag: "UIUX", tmid: 0),
        UserTagList(tag: "Python", tmid: 0),
        UserTagList(tag: "Django", tmid: 0),
        UserTagList(tag: "iPhone", tmid: 0)*/
    ]
    var myBooksArray: [FavoriteBookList] = [
        FavoriteBookList(tbid: 0, title: "책제목 테스트입니다1", author: "", thumbnailImage: "", rating: 0)/*,
        FavoriteBookList(tbid: 0, title: "책제목 테스트입니다2", author: "", thumbnailImage: "", rating: 0),
        FavoriteBookList(tbid: 0, title: "책제목 테스트입니다3", author: "", thumbnailImage: "", rating: 0),
        FavoriteBookList(tbid: 0, title: "책제목 테스트입니다4", author: "", thumbnailImage: "", rating: 0),
        FavoriteBookList(tbid: 0, title: "책제목 테스트입니다5", author: "", thumbnailImage: "", rating: 0)*/
    ]
    var myPostArray: [UserPostList] = [
        UserPostList(title: "리뷰리뷰립류테스트1", contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~", communityType: 0, pid: 0, commentCnt: 0, likeCnt: 0)/*,
        UserPostList(title: "립뷰뷰븁뷰뷰테스트2", contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~", communityType: 0, pid: 0, commentCnt: 0, likeCnt: 0)*/
    ]
    var myReviewsArray: [UserReviewList] = [
        UserReviewList(rid: 0, tbid: 0, uid: 0, contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..", views: 0, createAt: "", rating: 0, likeCnt: 0, isLiked: false, isAccessible: false, nickname: "", author: "", bookTitle: "리뷰리뷰립류테스트1", thumbnail: "")/*,
        UserReviewList(rid: 0, tbid: 0, uid: 0, contents: "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..", views: 0, createAt: "", rating: 0, likeCnt: 0, isLiked: false, isAccessible: false, nickname: "", author: "", bookTitle: "립뷰뷰븁뷰뷰테스트2", thumbnail: "")*/
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
        self.navigationItem.title = "내 정보"
        // navigation color 기본값 복원
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Accent Color")
        
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("MyProfile: 사용자 이메일을 불러올 수 없음.")
            RedirectView.redirectLoginView(previousView: self)
            return
        }
        guard let acessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("MyProfile: 토큰을 불러올 수 없음.")
            RedirectView.redirectLoginView(previousView: self)
            return
        }
        self.requestMyprofile(accessToken: acessToken)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let myprofileUpdateVC = segue.destination as? MyProfileUpdateViewController else {
            return
        }
        myprofileUpdateVC.thumbnailImageRecived = userImageView.image
        myprofileUpdateVC.nicknameTextRecived = userName
    }
    
    // MARK: - Request MyProfile
    private func requestMyprofile(accessToken: String) {
        print("request MyProfile: 통신 요청")
        MyProfileAPI.shared.myprofile(accessToken: accessToken) { (success, data, statuscode) in
            guard let myprofileData = data as? MyprofileModel else { return }
            if success {
                print("잘 되었따.")
                self.myTagsArray = (myprofileData.result?.userData?.userTagList)!
                self.myBooksArray = (myprofileData.result?.favoriteBookList)!.reversed()
                self.myPostArray = (myprofileData.result?.userPostList)!.reversed()
                self.myReviewsArray = (myprofileData.result?.userReviewList)!.reversed()
                DispatchQueue.main.async {
                    self.userName = (myprofileData.result?.userData?.nickname)!
                    self.setUserNameLabel(self.userName)
                    self.myTagsCollectionView.reloadData()
                    self.myBooksCollectionView.reloadData()
                    self.myPostCollectionView.reloadData()
                    self.myReviewsCollectionView.reloadData()
                    
                    /// load user thumbnail image
                    guard let userThumbnailImageString = myprofileData.result?.userData?.userThumbnail else {
                        self.setDefaultUserImage(imageName: "북키프사")
                        return
                    }
                    
                    if let userThumbnailImageURL = URL(string: userThumbnailImageString) {
                        do {
                            let userThumbnailData = try Data(contentsOf: userThumbnailImageURL)
                            self.userImageView.image = UIImage(data: userThumbnailData)
                        } catch {
                            print(error)
                        }
                    }
                    
                }
                
            } else {
                print("request MyProfile: false")
                if statuscode == 401 {
                    // 새로 AT 갱신할 것.
                    // 만료된 토큰입니다. RefreshToken의 기간이 지남
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
                                // 유효한 토큰입니다. AccessToken의 만료기간이 남음
                                print(tokens.errorMessage)
                            } else if statuscode == 403 {
                                // 유효하지 않은 토큰입니다. RefreshToken의 형식이 잘못됨
                                // 로그인 화면 리다이렉트
                                RedirectView.redirectLoginView(previousView: self)
                            } else if statuscode == 404 {
                                // RefreshTokenStorage와의 연결이 끊김
                            } else if statuscode == 405 {
                                // POST가 아닌 방식으로 접근 했을 경우
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
    
    private func setDefaultUserImage(imageName: String) {
        userImageView.image = UIImage(named: imageName)
    }
    
    private func setUserNameLabel(_ userName:String) {
        userNameLabel.text = userName + "님, 반가워요!"
    }
    
    private func setDefaultMyProfileView() {
        setUserImageViewCornerRadius()
        setDefaultUserImage(imageName: "북키프사")
        setUserNameLabel(userName)
//        self.navigationController?.navigationBar.topItem?.title = ""
//        self.navigationItem.title = "내 정보"
        
    }
    
    private func registerNibCollectionViewCell() {
        
        self.myPostCollectionView.register(UINib(nibName: "MyPostsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyPostsCollectionViewCell")

        self.myReviewsCollectionView.register(UINib(nibName: "MyReviewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyReviewsCollectionViewCell")
    }
    

    @IBAction func loginTestButton(_ sender: Any) {
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
            if myPostArray.count >= 2 {
                return 2
            } else {
                return myPostArray.count
            }
        } else {
            if myReviewsArray.count >= 2 {
                return 2
            } else {
                return myReviewsArray.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.myTagsCollectionView {
            guard let myTagsCell: MyTagsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTagsCell", for: indexPath) as? MyTagsCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            myTagsCell.tagNameLabel.text = "#\(myTagsArray[indexPath.row].tag)"
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
