//
//  RoadmapViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/08/09.
//

import UIKit

class RoadmapViewController: UIViewController {
    @IBOutlet weak var roadmapTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(named: "BlackOrWhite")
        self.navigationController?.navigationBar.topItem?.title = ""

    }
    
}

