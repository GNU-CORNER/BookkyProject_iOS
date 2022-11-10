//
//  SettingsViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit
import SafariServices
class SettingsViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor(named: "BlackOrWhite")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            //오픈소스 라이브러리
            let openSoureceLib = "https://mint-neem-ef5.notion.site/iOS-d9f6794e506f4870861b8187e8e30bf7"
            guard let url = URL(string: openSoureceLib) else { return }
            let safariVC = SFSafariViewController(url: url)
            safariVC.transitioningDelegate = self
            safariVC.modalPresentationStyle = .pageSheet
            present(safariVC, animated: true, completion: nil)
        }else if indexPath.row == 3 {
            //개인정보 처리방침
            let openSoureceLib = "https://mint-neem-ef5.notion.site/bc9a0aed6553428b9988ee436184d2cf"
            guard let url = URL(string: openSoureceLib) else { return }
            let safariVC = SFSafariViewController(url: url)
            safariVC.transitioningDelegate = self
            safariVC.modalPresentationStyle = .pageSheet
            present(safariVC, animated: true, completion: nil)
        }else if indexPath.row == 4 {
            // - [] 로그아웃
            Account.shared.requestSignout(vc: self)
        } else if indexPath.row == 5{
            // - [] 회원탈퇴
            Account.shared.requestWithdrawal(vc: self)
        }
    }
}

