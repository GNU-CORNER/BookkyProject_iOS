//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var myProfileTableView: UITableView!
    let userName = "사용자"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myProfileTableViewDelegate()
        myProfileTableViewDataSource()
        
        myProfileTableView.rowHeight = UITableView.automaticDimension
        myProfileTableView.estimatedRowHeight = 90

        nibCellConnect()
    }

    // MARK: connnect Nib Cell
    func nibCellConnect() {
        
        let favoriteNibCell = UINib(nibName: "FavoriteTagTableViewCell", bundle: nil)
        self.myProfileTableView.register(favoriteNibCell, forCellReuseIdentifier: "FavoriteTagsCellid")
        
        let myBookNibCell = UINib(nibName: "MyBooksTableViewCell", bundle: nil)
        self.myProfileTableView.register(myBookNibCell, forCellReuseIdentifier: "MyBooksTableViewCellid")
    }
}


// MARK: - extenstion TableView
extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: ProfileTableViewCell = self.myProfileTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
            cell.userNameLabel?.text = "\(userName)님, 반갑습니다."
            /// label text 내부의 특정 text만 색상 변경하기
            cell.userNameLabel?.asColor(targetString: userName, color: .systemBlue)
            cell.userImage?.image = UIImage(named: "thumbnail")
            cell.usserNameUpdateButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
            return cell
            
        } else if indexPath.section == 1 {
            let cell: FavoriteTagTableViewCell = self.myProfileTableView.dequeueReusableCell(withIdentifier: "FavoriteTagsCellid", for: indexPath) as! FavoriteTagTableViewCell
            cell.collectionHeaderLabel?.text = "\(userName)님의 관심 분야💭에요"
            /// label text 내부의 특정 text만 색상 변경하기
            cell.collectionHeaderLabel?.asColor(targetString: userName, color: .systemBlue)
            return cell
            
        } else if indexPath.section == 2 {
            let cell: MyBooksTableViewCell = self.myProfileTableView.dequeueReusableCell(withIdentifier: "MyBooksTableViewCellid", for: indexPath) as! MyBooksTableViewCell
            cell.myBooksHeader?.text = "\(userName)님의 관심 도서📖에요"
            /// label text 내부의 특정 text만 색상 변경하기
            cell.myBooksHeader?.asColor(targetString: userName, color: .systemBlue)
            return cell
            
        } else if indexPath.section == 3 {
            let cell: MyPostTableViewCell = self.myProfileTableView.dequeueReusableCell(withIdentifier: "MyPostCell", for: indexPath) as! MyPostTableViewCell
            cell.myPostHeader?.text = "\(userName)님이 쓴 글✏️에요"
            /// label text 내부의 특정 text만 색상 변경하기
            cell.myPostHeader?.asColor(targetString: userName, color: .systemBlue)
            return cell
            
        } else if indexPath.section == 4 {
            let cell: MyReviewTableViewCell = self.myProfileTableView.dequeueReusableCell(withIdentifier: "MyReviewCell", for: indexPath) as! MyReviewTableViewCell
            cell.myReviewHeader?.text = "\(userName)님이 쓴 후기✏️에요"
            /// label text 내부의 특정 text만 색상 변경하기
            cell.myReviewHeader?.asColor(targetString: userName, color: .systemBlue)
            return cell
            
        } else { return UITableViewCell() }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func myProfileTableViewDelegate() {
        myProfileTableView.delegate = self
    }

    func myProfileTableViewDataSource() {
        myProfileTableView.dataSource = self
    }
}

// MARK: extension UILabel
extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
