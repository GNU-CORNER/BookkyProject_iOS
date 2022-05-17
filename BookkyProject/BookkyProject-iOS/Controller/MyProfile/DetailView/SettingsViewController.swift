//
//  SettingsViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/17.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "설정"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    

}
