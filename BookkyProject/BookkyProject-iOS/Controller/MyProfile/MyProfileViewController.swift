//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class MyProfileViewController: UIViewController {
    
    var myTagsArray = ["iOS", "Swift", "Xcode", "UIUX", "Python", "Django", "iPhone"]
    var myBooksArray = ["책제목 테스트입니다1", "책제목 테스트입니다2", "책제목 테스트입니다3", "책제목 테스트입니다4", "책제목 테스트입니다5"]
    struct MyPost {
        static var title = ["리뷰리뷰립류테스트1", "립뷰뷰븁뷰뷰테스트2"]
        static var description = ["안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~", "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~."]
    }
    struct MyReviews {
        static var title = ["리뷰리뷰립류테스트1", "립뷰뷰븁뷰뷰테스트2"]
        static var description = ["안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..", "안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~..안녕하세요. 테스트입니다. 테스트 게시물 설명글 입니다만~.."]
        static var author = ["뮹먕밍뮹", "뮹뮹뮹밍밍밍미아망ㅁ아망"]
    }
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var myTagsCollectionView: UICollectionView!
    @IBOutlet weak var myBooksCollectionView: UICollectionView!
    @IBOutlet weak var myPostCollectionView: UICollectionView!
    @IBOutlet weak var myReviewsCollectionView: UICollectionView!
    
    var userName = "이다혜"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultMyProfileView()
        setCollectionViewDelegate()
        setCollectionViewDataSource()
        registerNibCollectionViewCell()
    }
    
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

    @IBAction func loginTestButton(_ sender: Any) {
         //스토리보드의 파일 찾기
        let storyboard: UIStoryboard? = UIStoryboard(name: "Login", bundle: Bundle.main)

        // 스토리보드에서 지정해준 ViewController의 ID
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginNavigation") else {
            return
        }

        // 화면 전환방식 선택 (default : .modal)
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen

        // 화면 전환!
        self.present(vc, animated: true)
    }

}

extension MyProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.myTagsCollectionView {
            return myTagsArray.count
        } else if collectionView == self.myBooksCollectionView {
            return myBooksArray.count
        } else if collectionView == self.myPostCollectionView {
            return 2
        } else {
            return 2
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
            myBooksCell.myBooksImageView.image = UIImage(named: "hi")
            myBooksCell.myBooksLabel.text = "\(myBooksArray[indexPath.row])"
            return myBooksCell
            
        } else if collectionView == self.myPostCollectionView {
            guard let myPostCell: MyPostCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPostsCollectionViewCell", for: indexPath) as? MyPostCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            myPostCell.myPostsTitleLabel.text = MyPost.title[indexPath.row]
            myPostCell.myPostsDescriptionLabel.text = MyPost.description[indexPath.row]
//            myPostCell.myPostsLikeLabel.text
//            myPostCell.myPostsCommentsLabel.text
            return myPostCell
            
        } else {
            guard let myReviewsCell: MyReviewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyReviewsCollectionViewCell", for: indexPath) as? MyReviewsCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            myReviewsCell.myReviewsBookTitleLabel.text = MyReviews.title[indexPath.row]
            myReviewsCell.myReviewsBookDescriptionLabel.text = MyReviews.description[indexPath.row]
            myReviewsCell.myReviewsBookAuthorLabel.text = MyReviews.author[indexPath.row]
            myReviewsCell.myReviewsBookImageView.image = UIImage(named: "생각하는북키1")
//            myReviewsCell.myReviewsLikeLabel.text
//            myReviewsCell.myReviewsLikeImageView.image
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
