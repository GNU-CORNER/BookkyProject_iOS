//
//  QnACommentViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/17.
//

import UIKit

class QnACommentViewController: UIViewController {

    @IBOutlet weak var QnACommentTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewCell()
        
    }
    private func setTableViewCell(){
        self.QnACommentTableView.delegate = self
        self.QnACommentTableView.dataSource = self
        let cellNib = UINib(nibName: "BoardTextCommentTableViewCell", bundle: nil)
        self.QnACommentTableView.register(cellNib, forCellReuseIdentifier: "BoardTextCommentTableViewCellid")
    }
    @objc
    func tapWrtieComment(sender: UIButton!){
        
    }

}
extension QnACommentViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footeriew = UIView(frame: CGRect(x: 0, y: 10, width: self.QnACommentTableView.frame.width, height: 30))
        if section == 0 {
            let writeTextField = UITextField(frame: CGRect(x: 5, y: 0, width: Int(self.QnACommentTableView.frame.width)*4/5, height: 30))
            writeTextField.layer.borderColor = UIColor(named: "grayColor")?.cgColor
            writeTextField.layer.borderWidth = 1
            writeTextField.layer.cornerRadius = 5
            let writeCommentButton = UIButton(frame: CGRect(x: Int(self.QnACommentTableView.frame.width)*4/5 + 10, y: 0, width: Int(self.QnACommentTableView.frame.width)*1/6, height: 30))
            writeCommentButton.setTitle("댓글 달기", for: .normal)
            writeCommentButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            writeCommentButton.tintColor = .white
            writeCommentButton.layer.borderColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeCommentButton.layer.borderWidth = 1
            writeCommentButton.layer.backgroundColor = UIColor(named: "PrimaryBlueColor")?.cgColor
            writeCommentButton.layer.cornerRadius = 10
            footeriew.addSubview(writeTextField)
            footeriew.addSubview(writeCommentButton)
            writeCommentButton.addTarget(self, action: #selector(tapWrtieComment), for: .touchUpInside)
        }
        
        return footeriew
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BoardTextCommentTableViewCellid", for: indexPath)as? BoardTextCommentTableViewCell else {return UITableViewCell()}
        cell.userNameLabel.text = "청순마녀"
        cell.userCommentContentsLabel.text = "안녕하세요 저는 청순마녀입니다. 안녕하세요 저는 청순마녀입니다. 안녕하세요 저는 청순마녀입니다. 안녕하세요 저는 청순마녀입니다. 안녕하세요 저는 청순마녀입니다. 반갑습니다!!!와우"
        cell.commentCreateAtLabel.text = "2022-02-14"
        cell.commentLikeThatCntLabel.text = "공감(\(1))"
        return cell
    }
    
    
}
