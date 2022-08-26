//
//  RoadmapViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/08/09.
//

import UIKit

class RoadmapViewController: UIViewController {
    
    var roadmapAnswer: [String] = [
        "HTTP가 무엇인가요?", "브라우저는 어떻게 동작하나요?", "인터넷은 무엇인가요?"
    ]
    
    var roadmapTopic: [String] = [
        "WEB", "Internet"
    ]
    
    var roadmapBooks: [String] = [
        "인터넷 바로보기", "HTTP구조와 딥러닝", "리액트로 배우는 네트워크", "React", "WEB1", "WEB2", "WEB3"
    ]
    
//    ["Internet이 무엇인가요?", "Internet은 어떻게 작동되나요?", "롤할사람?"]
    
//    Roadmap(topic: "Internet", answer: self.roadmapAnswerData, books: ["Internet1", "Internet2", "Internet3", "Internet4", "Internet5"])
    @IBOutlet weak var roadmapTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor(named: "BlackOrWhite")
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.roadmapTableView.delegate = self
        self.roadmapTableView.dataSource = self
        registerNibCell()
        setRecommendTableHeaderViewLayout()
    }
    
    private func registerNibCell() {
        self.roadmapTableView.register(UINib(nibName: "RoadmapTableViewCell", bundle: nil), forCellReuseIdentifier: "RoadmapTableViewCellid")
    }
    
}

extension RoadmapViewController: UITableViewDelegate, UITableViewDataSource {
    
    // FIXME: 전부 코드로 AutoLayout 설정해주기
    private func setRecommendTableHeaderViewLayout() {
        /// container  view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        containerView.backgroundColor = .systemGray
        
        /// center view
        let centerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/3 + 30, height: 60))
        centerView.backgroundColor = .white
        centerView.layer.cornerRadius = centerView.frame.height / 2
        centerView.layer.borderWidth = 1.0
        centerView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        
        let centerLabel = UILabel(frame: centerView.bounds) // frame 값 안주면 보이지 않는다.
        centerLabel.text = "center label."
        centerLabel.textAlignment = .center
        centerView.addSubview(centerLabel)
        centerView.center = containerView.center
        
        /// left view
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.width/2, height: 40))
        leftView.backgroundColor = .systemOrange
        
        let leftLabel = UILabel(frame: leftView.bounds) // bounds가 뭐지?
        leftLabel.text = "left label."
        leftLabel.textAlignment = .left
        leftView.addSubview(leftLabel)
        
        containerView.addSubview(centerView)
        
        containerView.addSubview(leftView)
        
//        NSLayoutConstraint.activate([
//            leftView.leadingAnchor.constraint(equalTo: self.roadmapTableView.leadingAnchor)
//        ])
        self.roadmapTableView.tableHeaderView = containerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roadmapAnswer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let answerCell: RoadmapTableViewCell = self.roadmapTableView.dequeueReusableCell(withIdentifier: "RoadmapTableViewCellid", for: indexPath) as? RoadmapTableViewCell else {
            return UITableViewCell()
        }
        answerCell.roadmapAnswerLabel.text = roadmapAnswer[indexPath.row]
        answerCell.selectionStyle = .none
        return answerCell
    }

}
