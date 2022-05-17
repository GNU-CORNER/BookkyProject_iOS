//
//  QnABoardTextDetailViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/16.
//

import UIKit

class QnABoardTextDetailViewController: UIViewController {
    @IBOutlet weak var QnATitleLabel: UILabel!
    @IBOutlet weak var QnACreateDateLabel: UILabel!
    @IBOutlet weak var QnAViewImage: UIImageView!
    @IBOutlet weak var QnAViewCnt: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var QnAContentsLabel: UILabel!
    @IBOutlet weak var likeCntLButton: UIButton!
    @IBOutlet weak var CommetButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var writeAnswerButton: UIButton!
    @IBOutlet weak var QnATableView: UITableView!
   
    var PID : Int = 0
    var boardTypeNumber : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        setTableViewCell()
        setBoardTextDetailUI()
    }
    
    func setTableViewCell(){
        self.QnATableView.dataSource = self
        self.QnATableView.delegate = self
        let cellNib = UINib(nibName: "QnaAnswerTableViewCell", bundle: nil)
        self.QnATableView.register(cellNib, forCellReuseIdentifier: "QnaAnswerTableViewCellid")
        
    }
    func setBoardTextDetailUI(){
        self.QnATitleLabel.font = UIFont.systemFont(ofSize: 20)
        self.QnACreateDateLabel.font = UIFont.systemFont(ofSize: 11)
        self.QnACreateDateLabel.textColor = .gray
        self.QnAViewCnt.font = UIFont.systemFont(ofSize: 11)
        self.QnAContentsLabel.font = UIFont.systemFont(ofSize: 13)
        
        self.userNameLabel.font = UIFont.systemFont(ofSize: 14)
        self.likeCntLButton.setTitle("좋아요(\(10))", for: .normal)
        self.likeCntLButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.CommetButton.setTitle("댓글(\(7))", for: .normal)
        self.CommetButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.answerLabel.text = "답변(\(2))"
        self.answerLabel.font = UIFont.systemFont(ofSize: 12)
        self.answerLabel.textColor = UIColor(named: "PrimaryBlueColor")
        self.writeAnswerButton.setTitle("답변달기", for: .normal)
        self.writeAnswerButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
    }
   
    @IBAction func tapGoCommentView(_ sender: Any) {
        guard let CommentViewConroller  = self.storyboard?.instantiateViewController(withIdentifier: "QnACommentViewController")as? QnACommentViewController else {return}
        self.navigationController?.pushViewController(CommentViewConroller, animated: true)
    }
    
    
}
extension QnABoardTextDetailViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QnaAnswerTableViewCellid", for: indexPath) as? QnaAnswerTableViewCell else {return UITableViewCell()}
        cell.userNameLabel.text = "김우석"
        cell.contentsLabel.text = "답글을 쓴다면????????????답글을 쓴다면????????????답글을 쓴다면????????????답글을 쓴다면????????????답글을 쓴다면????????????답글을 쓴다면????????????답글을 쓴다면????????????"
        cell.createDataLabel.text = "2022-02-14 11::34"
        cell.choiceAnswerLabel.text = "채택된 글"
        cell.likeCntLabel.setTitle("좋아요(\(1))", for: .normal)
        cell.commentButton.setTitle("댓글(\(5))", for: .normal)
        return cell
    }
    
    
}
