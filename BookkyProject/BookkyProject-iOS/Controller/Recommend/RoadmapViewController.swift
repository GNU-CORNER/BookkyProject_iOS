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
        let containerViewHeight: CGFloat = 100.0
        let centerViewHeight: CGFloat = 60.0
        let sideViewHeight: CGFloat = 40.0 // left, right view
        let sideArrowViewHeight: CGFloat = 20.0
        
        /// container  view
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: containerViewHeight))
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.backgroundColor = .systemGray
//        NSLayoutConstraint.activate([
//            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            containerView.heightAnchor.constraint(equalToConstant: 100)
//        ])
        
        /// left view
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.width/2, height: sideViewHeight))
        let leftView = UIButton(frame: CGRect(x: 0, y: 0, width: containerView.frame.width/2, height: sideViewHeight))
        leftView.backgroundColor = UIColor(named: "primaryColor")
        
        let leftLabel = UILabel(frame: leftView.bounds) // bounds가 뭐지?
        leftLabel.text = "left label."
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.textColor = .white
        leftLabel.font = UIFont.systemFont(ofSize: 14)
        leftView.addSubview(leftLabel)
        
        leftLabel.leadingAnchor.constraint(equalTo: leftView.leadingAnchor, constant: 10).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        
        containerView.addSubview(leftView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        leftView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: sideViewHeight).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2).isActive = true
        /// button clicked
        leftView.addTarget(self, action: #selector(headerViewLeftButtonClicked(sender:)), for: .touchUpInside)
        
        /// right view
//        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: containerView.frame.width/2, height: sideViewHeight))
        let rightView = UIButton(frame: CGRect(x: 0, y: 0, width: containerView.frame.width/2, height: sideViewHeight))
        rightView.backgroundColor = UIColor(named: "primaryColor")

        let rightLabel = UILabel(frame: rightView.bounds) // bounds가 뭐지?
        rightLabel.text = "right label."
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.textColor = .white
        rightLabel.font = UIFont.systemFont(ofSize: 14)
        rightView.addSubview(rightLabel)

        rightLabel.trailingAnchor.constraint(equalTo: rightView.trailingAnchor, constant: -10).isActive = true
        rightLabel.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true

        containerView.addSubview(rightView)
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        rightView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        rightView.heightAnchor.constraint(equalToConstant: sideViewHeight).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 2).isActive = true
        /// button clicked
        rightView.addTarget(self, action: #selector(headerViewRightButtonClicked(sender:)), for: .touchUpInside)
        
        /// center view
        let centerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width/3 + 30, height: centerViewHeight))
        centerView.backgroundColor = .white
        centerView.layer.cornerRadius = centerView.frame.height / 2
        centerView.layer.borderWidth = 2.0
        centerView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        
        let centerLabel = UILabel(frame: centerView.bounds) // frame 값 안주면 보이지 않는다.
        centerLabel.text = "center label."
        centerLabel.textAlignment = .center
        centerView.addSubview(centerLabel)
        centerView.center = containerView.center
        
        containerView.addSubview(centerView)
        
        /// left, right button view
        let rightArrowImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: sideArrowViewHeight, height: sideArrowViewHeight))
        rightArrowImageView.image = UIImage(systemName: "arrowtriangle.forward.circle")
        rightArrowImageView.tintColor = .white
        rightView.addSubview(rightArrowImageView)
        rightArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        rightArrowImageView.heightAnchor.constraint(equalToConstant: sideArrowViewHeight).isActive = true
        rightArrowImageView.widthAnchor.constraint(equalToConstant: sideArrowViewHeight).isActive = true
        rightArrowImageView.leadingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: 5).isActive = true
        rightArrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        let leftArrowImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: sideArrowViewHeight, height: sideArrowViewHeight))
        leftArrowImageView.image = UIImage(systemName: "arrowtriangle.backward.circle")
        leftArrowImageView.tintColor = .white
        leftView.addSubview(leftArrowImageView)
        leftArrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        leftArrowImageView.heightAnchor.constraint(equalToConstant: sideArrowViewHeight).isActive = true
        leftArrowImageView.widthAnchor.constraint(equalToConstant: sideArrowViewHeight).isActive = true
        leftArrowImageView.trailingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: -5).isActive = true
        leftArrowImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true

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

extension RoadmapViewController {
    
    @objc func headerViewRightButtonClicked(sender: UIButton!) {
        print("click right")
    }
    
    @objc func headerViewLeftButtonClicked(sender: UIButton!) {
        print("click left")
    }
}
