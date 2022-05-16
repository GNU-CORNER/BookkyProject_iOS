//
//  WriteTextSearchBookViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/13.
//

import UIKit

class WritePostBookSearchViewController: UIViewController {


    @IBOutlet weak var bookSearchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBookSearchTableView()
    }
    
    @IBAction func tapCancelViewButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    private func setBookSearchTableView(){
        self.bookSearchTableView.delegate = self
        self.bookSearchTableView.dataSource = self
    }
}
extension WritePostBookSearchViewController : UITableViewDelegate ,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell  = bookSearchTableView.dequeueReusableCell(withIdentifier: "WritePostBookSearchTableViewCellid", for: indexPath)as? WritePostBookSearchTableViewCell else {return UITableViewCell()}
        cell.bookImage.image = UIImage(named: "Bookky_Logo")
        cell.bookNameLabel.text =  "리액트 바로가기"
        cell.bookAuthorNPublisher.text = "전인혁/인피니티북스"
        return cell
    }
    
    
    
}

