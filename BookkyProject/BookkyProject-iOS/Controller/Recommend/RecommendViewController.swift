//
//  RecommendViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class RecommendViewController: UIViewController {
    
    struct RoadmapBookkyCellData {
        static var roadmap: String = "안내견 북키"
        var title: String
        var type: String
        var description: String
    }
    var roadmapBookkyArry: [RoadmapBookkyCellData] = [
        RoadmapBookkyCellData(title: "\(RoadmapBookkyCellData.roadmap) - FrontEnd", type: "FrontEnd", description: "요즘 유행하는 웹개발, 나도 해볼까? \n북키가 안내 해줄게!"),
        RoadmapBookkyCellData(title: "\(RoadmapBookkyCellData.roadmap) - Backend", type:"Backend" ,description: "진짜 프로그래머는 백엔드를 한다! 나도 해볼까? \n북키가 안내 해줄게!")
    ]
    
    @IBOutlet weak var recommendTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.recommendTableView.delegate = self
        self.recommendTableView.dataSource = self
        registerNibCell()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "추천받개"
    }
    
    private func registerNibCell() {
        self.recommendTableView.register(UINib(nibName: "RoadmapBookkyTableViewCell", bundle: nil), forCellReuseIdentifier: "RoadmapBookkyCellid")
    }
}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    
    // NOTE: 추천받개 배너 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roadmapBookkyArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let bookkyCell:  RoadmapBookkyTableViewCell = self.recommendTableView.dequeueReusableCell(withIdentifier: "RoadmapBookkyCellid", for: indexPath) as? RoadmapBookkyTableViewCell else {
            return UITableViewCell()
        }
        bookkyCell.selectionStyle = .none
        bookkyCell.bookkyTitle.text = roadmapBookkyArry[indexPath.row].title
        bookkyCell.bookkyTitle.textColor = UIColor(named: "primaryColor")
        bookkyCell.bookkyDescription.text = roadmapBookkyArry[indexPath.row].description
        bookkyCell.bookkyDescription.textColor = UIColor(named: "primaryColor")
        return bookkyCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roadmapStoryboard: UIStoryboard = UIStoryboard(name: "Roadmap", bundle: nil)
        guard let roadmapVC = roadmapStoryboard.instantiateViewController(withIdentifier: "Roadmap") as? RoadmapViewController else {
            return
        }
        let titleName = UILabel()
        titleName.text = "\(roadmapBookkyArry[indexPath.row].type) 로드맵"
        titleName.asColr(targetString: roadmapBookkyArry[indexPath.row].type, color: UIColor(named: "primaryColor") ?? UIColor.black)
        titleName.sizeToFit()
        roadmapVC.navigationItem.titleView = titleName
        self.navigationController?.pushViewController(roadmapVC, animated: true)
    }
    
}
