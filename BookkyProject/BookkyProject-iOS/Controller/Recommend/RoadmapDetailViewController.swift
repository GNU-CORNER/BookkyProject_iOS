//
//  RoadmapDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/08/27.
//

import UIKit

class RoadmapDetailViewController: UIViewController {
    
    var topic = ""
    var question = ""
    
    @IBOutlet weak var topicView: UIView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.topicLabel?.text = topic
        self.questionTitle?.text = question
        
        setTopicView()
    }
    
    private func setTopicView() {
        topicView.layer.borderWidth = 1.0
        topicView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        topicView.layer.cornerRadius = topicView.frame.height / 2
        topicLabel.sizeToFit()
//        topicLabel.frame.width = topicLabel.frame.width + 20
    }
    
}
