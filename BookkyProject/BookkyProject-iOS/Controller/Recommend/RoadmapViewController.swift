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
        setRecommendTableHeaderView()
    }
    
    private func registerNibCell() {
        self.roadmapTableView.register(UINib(nibName: "RoadmapTableViewCell", bundle: nil), forCellReuseIdentifier: "RoadmapTableViewCellid")
    }
    
}

extension RoadmapViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setRecommendTableHeaderView() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        header.backgroundColor = .systemOrange
        let headerLabel = UILabel()
        headerLabel.text = "여기는 뿡붕이"
        headerLabel.textAlignment = .center
        header.addSubview(headerLabel)
        roadmapTableView.tableHeaderView = header
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
