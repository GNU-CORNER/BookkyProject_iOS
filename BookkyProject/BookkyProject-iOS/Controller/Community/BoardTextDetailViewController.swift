//
//  BoardTextDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/04.
//

import UIKit

class BoardTextDetailViewController: UIViewController {
    var PID : Int = 0
    @IBOutlet weak var PIDLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.PIDLabel.text = "\(self.PID)"
    }
    



}
