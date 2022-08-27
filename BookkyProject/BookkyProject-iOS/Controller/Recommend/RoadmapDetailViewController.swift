//
//  RoadmapDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/08/27.
//

import UIKit

class RoadmapDetailViewController: UIViewController {
    
    @IBOutlet weak var topicView: UIView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var topic = ""
    var question = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        self.topicLabel?.text = topic
        self.questionTitle?.text = question
    }

}
