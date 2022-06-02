//
//  SettingsViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 8 {
            // - [] 로그아웃
            Account.shared.requestSignout(vc: self)
        } else if indexPath.row == 9 {
            // - [] 회원탈퇴
            
        }
    }
}

