//
//  ViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/13.
//refactor

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    var userName = "사용자"
    
    var buttonText = "태그 더보기>"
    var bookList : [BookList] = []
    var BID : Int = 0
    var TID : Int = 0
    // MARK: - 추천하개 UI
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var recommendExplainLabel: UILabel!
    @IBOutlet weak var bookynatorButtonStackView: UIStackView!
    @IBOutlet weak var bookynatorGoButtonFirst: UIButton!
    @IBOutlet weak var bookynatorGoButtonSecond: UIButton!
    @IBOutlet weak var roadMapButtonStackView: UIStackView!
    @IBOutlet weak var roadMapGoButtonFirst: UIButton!
    @IBOutlet weak var roadMapGoButtonSecond: UIButton!
    // MARK: - 커뮤니티 button&Label
    @IBOutlet weak var communityStackView: UIStackView!
    @IBOutlet weak var communityGoButton: UIButton!
    @IBOutlet weak var boardButtonStackView: UIStackView!
    @IBOutlet weak var freeBoardGoButton: UIButton!
    @IBOutlet weak var freeBoardTextGoButton: UIButton!
    @IBOutlet weak var QnABoardGoButton: UIButton!
    @IBOutlet weak var QnABoardTextGoButton: UIButton!
    @IBOutlet weak var hotBoardGoButton: UIButton!
    @IBOutlet weak var hoeBoardTextGoButton: UIButton!
    // MARK: - 도서리스트 테이블
    @IBOutlet weak var bookListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBookTableView()
        self.setRecommendView()
        self.setCommunityView()
        getBookData()
        statusBarView?.backgroundColor = UIColor(named:"primaryColor")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBookData()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.bookListTableView.reloadData()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    // MARK: - 추천하개뷰 Set
    private func setRecommendView(){
        self.communityStackView.layer.addBorder([.top,.bottom], color: UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1), width: 1.0)
        self.recommendButton.setTitle("추천하개 >", for: .normal)
        self.recommendButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.recommendButton.tintColor = UIColor.black
        self.recommendExplainLabel.text = "당신에게 적합한 책을 찾아 줄게요!"
        self.recommendExplainLabel.font = UIFont.systemFont(ofSize: 12)
        self.recommendExplainLabel.textColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        
        self.bookynatorButtonStackView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        self.bookynatorButtonStackView.layer.borderWidth = 2
        self.bookynatorButtonStackView.layer.cornerRadius = 10
        
        self.bookynatorGoButtonFirst.setTitle("당신의 책을 찾아보세요.", for: .normal)
        self.bookynatorGoButtonFirst.tintColor =  UIColor.black
        self.bookynatorGoButtonSecond.setTitle("북키네이터", for: .normal)
        self.bookynatorGoButtonSecond.tintColor =  UIColor.black
        self.bookynatorGoButtonSecond.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        
        self.roadMapButtonStackView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        self.roadMapButtonStackView.layer.borderWidth = 2
        self.roadMapButtonStackView.layer.cornerRadius = 10
        
        self.roadMapGoButtonFirst.setTitle("나의 개발 지도는?", for: .normal)
        self.roadMapGoButtonFirst.tintColor =  UIColor.black
        self.roadMapGoButtonSecond.setTitle("♨️도그맵 보기", for: .normal)
        self.roadMapGoButtonSecond.tintColor =  UIColor.black
        self.roadMapGoButtonSecond.titleLabel?.font = UIFont.systemFont(ofSize: 24)
    }
    // MARK: - 커뮤니티뷰 SET
    private func setCommunityView(){
        self.communityGoButton.setTitle("커뮤니티 >", for: .normal)
        self.communityGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.communityGoButton.tintColor = UIColor.black
        
        self.boardButtonStackView.layer.borderWidth = 1
        self.boardButtonStackView.layer.cornerRadius = 10
        self.boardButtonStackView.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
        self.freeBoardGoButton.setTitle("자유게시판", for: .normal)
        self.freeBoardGoButton.tintColor = UIColor.black
        self.freeBoardTextGoButton.setTitle("카카오 공채 떳던데 보신분 있으 신가요 ?", for: .normal)
        self.freeBoardTextGoButton.tintColor = UIColor.black
        
        self.QnABoardGoButton.setTitle("Q&A게시판", for: .normal)
        self.QnABoardGoButton.tintColor = UIColor.black
        self.QnABoardTextGoButton.setTitle("함수를 썻는데 너무이상해요함수를 썻는데 너무 이상해요  ", for: .normal)
        self.QnABoardTextGoButton.tintColor = UIColor.black
        
        self.hotBoardGoButton.setTitle("HoT게시판", for: .normal)
        self.hotBoardGoButton.tintColor = UIColor.black
        self.hoeBoardTextGoButton.setTitle("한번 읽어보고 마스터한 책사실분 ?", for: .normal)
        self.hoeBoardTextGoButton.tintColor = UIColor.black
        
    }
    private func setBookTableView(){
        self.bookListTableView.dataSource = self
        self.bookListTableView.delegate = self
        let cellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.bookListTableView.register(cellNib, forCellReuseIdentifier: "BookTableViewCellid")
    }
    private func getBookData(){
        GetBookData.shared.getBookData(){ (sucess,data) in
            if sucess {
                guard let bookData = data as? BookInformation else {return}
                self.bookList = bookData.result.bookList
                if bookData.success{
                    DispatchQueue.main.async {
                        self.userName = bookData.result.userData.nickname
                        self.bookListTableView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
            }
        }
    }
    @objc
    func tapAddMoreTagViewButton(sender: UIButton!){
        performSegue(withIdentifier: "tagMoreButtonSegueid", sender: self)
    }
    @IBAction func tapCommunityGoButton(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func tapGoRecommandButton(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
    @IBAction func tapGoFreeBoardButton(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    @IBAction func tapGoQnABoardButton(_ sender: UIButton) {
        
        tabBarController?.selectedIndex = 1
        let navigationController = tabBarController?.viewControllers![1] as! UINavigationController
        let communityViewController = navigationController.topViewController as! CommunityViewController
        communityViewController.boardTypeNumber = 2
        
        
    }
}


extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bookListTableView.frame.width, height: 180))
        headerView.backgroundColor = UIColor(named: "primaryColor")
        let welComeLabel = UILabel(frame: CGRect(x: self.bookListTableView.frame.width*(1/15), y: 25, width: self.bookListTableView.frame.width*(2/3), height: 180))
        let noticeButton = UIButton(frame: CGRect(x: self.bookListTableView.frame.width-60, y: 0, width: 50, height: 50))
        headerView.addSubview(welComeLabel)
        headerView.addSubview(noticeButton)
        welComeLabel.textColor = UIColor.white
        welComeLabel.text = "오늘\n\(userName)님에게\n추천하는 책이에요!"
        welComeLabel.asColr(targetString: userName, color: .black)
        welComeLabel.adjustsFontSizeToFitWidth = true
        welComeLabel.numberOfLines = 3
        welComeLabel.font = UIFont.systemFont(ofSize: 36)
        welComeLabel.sizeToFit()
        noticeButton.setImage(UIImage(systemName: "bell"), for: .normal)
        noticeButton.tintColor = UIColor.black
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footeriew = UIView(frame: CGRect(x: 0, y: 0, width: self.bookListTableView.frame.width, height: 30))
        let addMoreTagViewButton = UIButton(frame: CGRect(x: self.bookListTableView.frame.width-80, y: 0, width: 80, height: 30))
        footeriew.addSubview(addMoreTagViewButton)
        addMoreTagViewButton.setTitle(buttonText, for: .normal)
        addMoreTagViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        addMoreTagViewButton.tintColor = UIColor.white
        footeriew.backgroundColor = UIColor(named: "primaryColor")
        addMoreTagViewButton.addTarget(self, action: #selector(tapAddMoreTagViewButton), for: .touchUpInside)
        return footeriew
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:BookTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCellid", for: indexPath) as? BookTableViewCell else { return UITableViewCell()}
        cell.setBookInformation(model: bookList[indexPath.row])
        cell.cellDelegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 2 {
            return 230
        }else {
            return 0
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookDetailViewSegue"{
            let BookDetailViewController = segue.destination as! BookDetailViewController
            BookDetailViewController.BID = self.BID
        }else if segue.identifier == "bookTagViewSegue"{
            guard let tagViewController = segue.destination as? TagViewController else {return}
            tagViewController.TID = self.TID
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? BookTableViewCell else {return}
        self.TID = cell.TID
        print("\(self.TID)")
        performSegue(withIdentifier: "bookTagViewSegue", sender: indexPath.row)
    }
}

extension HomeViewController:BookCollectionViewCellDeleGate{
    func collectionView(collectionviewcell: BookCollectionViewCell?, index: Int, didTappedInTableViewCell: BookTableViewCell) {
        self.BID = collectionviewcell?.BID ?? 0
        performSegue(withIdentifier: "bookDetailViewSegue", sender: self)
    }
}

