//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit
protocol viewRefreshAfterLogin {
    
}

class MyProfileViewController: UIViewController {
    
    var myTagsArray: [UserTagList] = []
    var myBooksArray: [FavoriteBookList] = []
    var myPostArray: [UserPostList] = []
    var myReviewsArray: [UserReviewList] = []
    
    @IBOutlet weak var loginButton: UIBarButtonItem!
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

//        setDefaultMyProfileView()
//        setCollectionViewDelegate()
//        setCollectionViewDataSource()
//        registerNibCollectionViewCell()
//        self.loginButton.customView?.isHidden = true
//
//        setView()
    }
    
    
    public func setView() {
        self.navigationItem.title = "내 정보"
        // navigation color 기본값 복원
        self.navigationController?.navigationBar.tintColor = UIColor(named: "Accent Color")
        
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("MyProfile: 사용자 이메일을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        guard let acessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("MyProfile: 토큰을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        self.requestMyprofile(accessToken: acessToken)
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        setDefaultMyProfileView()
        setCollectionViewDelegate()
        setCollectionViewDataSource()
        registerNibCollectionViewCell()
        self.loginButton.customView?.isHidden = true
        
        setView()
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
            print("\(success)")
            if success {
                print("잘 되었따.")
                self.myTagsArray = (myprofileData.result?.userData?.userTagList)!
                self.myBooksArray = (myprofileData.result?.favoriteBookList)!.reversed()
                self.myPostArray = (myprofileData.result?.userPostList)!
                self.myReviewsArray = (myprofileData.result?.userReviewList)!
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
                        self.userImageView.load(url: userThumbnailImageURL)
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
                        print("사용자 이메일을 불러올 수 없음.")
                        return
                    }
                    guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
                          let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
                        print("토큰을 불러올 수 없음.")
                        return
                    }
                    print("갱신요청")
                    Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
                        print(success)
                        guard let tokens = data as? RefreshModel else { return }
                        if success {
                            if let newAccessToken = tokens.result?.accessToken {
                                if !KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                                    print("새로운 토큰 제대로 저장이 안되었어요~~~~")
                                }
                                self.requestMyprofile(accessToken: previousAccessToken)
                            }
                        } else {
                            print(statuscode)
                            if statuscode == 400 {
                                // 유효한 토큰입니다. AccessToken의 만료기간이 남음
                                print(tokens.errorMessage)
                            } else if statuscode == 401 {
                                // 만료된 토큰입니다.
                                print(tokens.errorMessage)
                                RedirectView.loginView(previousView: self)
                            } else if statuscode == 403 {
                                // 유효하지 않은 토큰입니다. RefreshToken의 형식이 잘못됨
                                // 로그인 화면 리다이렉트
                                RedirectView.loginView(previousView: self)
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
        userNameLabel.asColr(targetString: userName, color: UIColor(named: "primaryColor") ?? UIColor.blue)
    }
    
    private func setDefaultMyProfileView() {
        setUserImageViewCornerRadius()
        setDefaultUserImage(imageName: "북키프사")
        setUserNameLabel(userName)
    }
    
    private func registerNibCollectionViewCell() {
        
        self.myPostCollectionView.register(UINib(nibName: "MyPostsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyPostsCollectionViewCell")

        self.myReviewsCollectionView.register(UINib(nibName: "MyReviewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyReviewsCollectionViewCell")
    }
    

    @IBAction func loginTestButton(_ sender: Any) {
        RedirectView.loginView(previousView: self)
    }

}


// MARK: - UICollectionView Extension
extension MyProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.myTagsCollectionView {
            let homeStoryboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            guard let TagVC = homeStoryboard.instantiateViewController(withIdentifier: "TagViewController") as? TagViewController else {
                return
            }
            TagVC.TID = self.myTagsArray[indexPath.row].tmid
            self.navigationController?.pushViewController(TagVC, animated: true)
            
        } else if collectionView == self.myBooksCollectionView {
            let homeStoryboard : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            guard let BookDetailVC = homeStoryboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController else {
                return
            }
            BookDetailVC.BID = self.myBooksArray[indexPath.row].tbid
            self.navigationController?.pushViewController(BookDetailVC, animated: true)
            
        } else if collectionView == self.myPostCollectionView {
            let CommunityStoryboard: UIStoryboard = UIStoryboard(name: "Community", bundle: nil)
            guard let BoardTextDetailVC = CommunityStoryboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BoardTextDetailViewController else {
                return
            }
            BoardTextDetailVC.PID = myPostArray[indexPath.row].pid
            BoardTextDetailVC.boardTypeNumber = myPostArray[indexPath.row].communityType
            //?
            BoardTextDetailVC.previousBoardNumber = 0
            self.navigationController?.pushViewController(BoardTextDetailVC, animated: true)
            
        } else {
            
        }
    }
        
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
                myBooksCell.myBooksImageView.load(url: thumbnailUrl)
            }
            myBooksCell.myBooksLabel.text = "\(myBooksArray[indexPath.row].title)"
            return myBooksCell
            
        } else if collectionView == self.myPostCollectionView {
            guard let myPostCell: MyPostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPostsCollectionViewCell", for: indexPath) as? MyPostCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            let commentImage = UIImage(named: "comment")! as UIImage
            let commentImageWithColor = commentImage.imageWithColor(color: UIColor(named: "PrimaryBlueColor") ?? UIColor.blue)
            
            myPostCell.myPostsTitleLabel.text = myPostArray[indexPath.row].title
            myPostCell.myPostsDescriptionLabel.text = myPostArray[indexPath.row].contents
            myPostCell.myPostsLikeLabel.text = String(myPostArray[indexPath.row].likeCnt)
            myPostCell.myPostsCommentsLabel.text = String(myPostArray[indexPath.row].commentCnt)
            myPostCell.myPostsCommentsImageView.image = commentImageWithColor
            
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
                myReviewsCell.myReviewsBookImageView.load(url: thumbnailUrl)
            }
            myReviewsCell.myReviewsLikeLabel.text = String(myReviewsArray[indexPath.row].likeCnt)

            return myReviewsCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.myTagsCollectionView {
            guard let myTagsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyTagsCell", for: indexPath) as? MyTagsCollectionViewCell else {
                return .zero
            }
            myTagsCell.tagNameLabel.text = "#\(myTagsArray[indexPath.row].tag)"
            myTagsCell.tagNameLabel.sizeToFit()
            let cellWidth = myTagsCell.tagNameLabel.frame.width + 16
            return CGSize(width: cellWidth, height: 25)
        }
        if collectionView == self.myBooksCollectionView {
            return CGSize(width: 80, height: 125)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
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
