//
//  MyPostsMoreTableViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/07/09.
//

import UIKit

class MyPostsMoreTableViewController: UITableViewController {
    
    var myPostsMoreArray: [UserPostList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultView()
        registerMyPostsCellNib()
        
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
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.tintColor = UIColor(named: "BlackOrWhite")
        setDefaultView()
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
                    self.tableView.reloadData()
                }
            } else {

            }
        }
    }
}

// MARK: - Table view data source
extension MyPostsMoreTableViewController {
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPostsMoreArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myPostsMoreArray[indexPath.row].communityType == 0 {
            guard let defaultCell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCellNib", for: indexPath) as? SearchPostTableViewCell else {
                return UITableViewCell()
            }
            let commentImage = UIImage(named: "comment")! as UIImage
            let commentImageWithColor = commentImage.imageWithColor(color: UIColor(named: "PrimaryBlueColor") ?? UIColor.blue)
            defaultCell.postTitleLabel.text = myPostsMoreArray[indexPath.row].title
            defaultCell.postContentsLabel.text = myPostsMoreArray[indexPath.row].contents
            defaultCell.likThatCountLabel.text = String(myPostsMoreArray[indexPath.row].likeCnt)
            defaultCell.commentLabel.text = String(myPostsMoreArray[indexPath.row].commentCnt)
            defaultCell.likeThatImage.image = UIImage(named: "likeThat")
            defaultCell.commentImage.image = commentImageWithColor
            defaultCell.selectionStyle = .none
            return defaultCell
            
        } else {
            guard let qnaCell = tableView.dequeueReusableCell(withIdentifier: "QnATableVIewCellid", for: indexPath) as? QnABoardTableViewCell else{
                return UITableViewCell()
            }
            let commentImage = UIImage(named: "comment")! as UIImage
            let commentImageWithColor = commentImage.imageWithColor(color: UIColor(named: "PrimaryBlueColor") ?? UIColor.blue)
            qnaCell.titleLabel.text = myPostsMoreArray[indexPath.row].title
            qnaCell.contentsLabel.text = myPostsMoreArray[indexPath.row].contents
            qnaCell.likeCntLabel.text = String(myPostsMoreArray[indexPath.row].likeCnt)
            qnaCell.commentLabel.text = String(myPostsMoreArray[indexPath.row].commentCnt)
            qnaCell.likeCntImage.image = UIImage(named: "likeThat")
            qnaCell.commentImage.image = commentImageWithColor
//            qnaCell.replyCnt = myPostsMoreArray[indexPath.row]. replyCnt가 없음!!!
            qnaCell.selectionStyle = .none
            return qnaCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let CommunityStoryboard: UIStoryboard = UIStoryboard(name: "Community", bundle: nil)
        guard let BoardTextDetailVC = CommunityStoryboard.instantiateViewController(withIdentifier: "BookDetailViewController") as? BoardTextDetailViewController else {
            return
        }
        BoardTextDetailVC.PID = myPostsMoreArray[indexPath.row].pid
        BoardTextDetailVC.boardTypeNumber = myPostsMoreArray[indexPath.row].communityType
        BoardTextDetailVC.previousBoardNumber = 0
        self.navigationController?.pushViewController(BoardTextDetailVC, animated: true)
        
    }
}


extension MyPostsMoreTableViewController {
    
    private func setDefaultView() {
        self.navigationController?.navigationBar.tintColor = UIColor(named: "BlackOrWhite")
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "내 글 보기"
    }
    
    @objc func searchButtonTapped() {
        // '내글보기'에서 검색 버튼을 누르면 이 함수가 수행된다.
    }
    
    private func registerMyPostsCellNib() {
        let defaultCellNibName = UINib(nibName: "SearchPostTableViewCell", bundle: nil)
        tableView.register(defaultCellNibName, forCellReuseIdentifier: "searchTableViewCellNib")
        
        let qnaCellNibName = UINib(nibName: "QnABoardTableViewCell", bundle: nil)
        tableView.register(qnaCellNibName, forCellReuseIdentifier: "QnATableVIewCellid")
    }

}
