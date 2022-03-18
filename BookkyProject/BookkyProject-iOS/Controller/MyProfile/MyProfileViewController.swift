//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var myProfileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewDelegate()
        tableViewDataSource()

        let cellNib = UINib(nibName: "FavoriteTagTableViewCell", bundle: nil)
        self.myProfileTableView.register(cellNib, forCellReuseIdentifier: "FavoriteTagsCellid")
    }
    
}

extension MyProfileViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userName = "황랑귀"
        if indexPath.section == 0 {
            let cell: ProfileTableViewCell = self.myProfileTableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileTableViewCell
            cell.userNameLabel.text = "\(userName)님, 반갑습니다."
            cell.userImage?.image = UIImage(named: "미모티콘-다혜")
            cell.usserNameUpdateButton.setImage(UIImage(systemName: "arrowtriangle.right.fill"), for: .normal)
            return cell
        } else if indexPath.section == 1 {
            let cell: FavoriteTagTableViewCell = self.myProfileTableView.dequeueReusableCell(withIdentifier: "FavoriteTagsCellid", for: indexPath) as! FavoriteTagTableViewCell
            cell.collectionHeaderLabel?.text = "\(userName)님의 관심도서에요."
            return cell
        } else {
            return UITableViewCell()
        }
    }



    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableViewDelegate() {
        myProfileTableView.delegate = self
    }

    func tableViewDataSource() {
        myProfileTableView.dataSource = self
    }
}
