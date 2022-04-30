//
//  ViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/13.
//refactor

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate {
    let user = "황랑귀"
    //    let bookList = BookData()
    var buttonText = "태그 더보기>"
    var bookList : [BookList] = []
    //
    var BID : Int = 0
    //추천하게 button&Label
    var cellSize : CGFloat = 0
    var TID : Int = 0
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var recommendExplainLabel: UILabel!
    
    @IBOutlet weak var bookynatorButtonStackView: UIStackView!
    @IBOutlet weak var bookynatorGoButtonFirst: UIButton!
    @IBOutlet weak var bookynatorGoButtonSecond: UIButton!
    
    @IBOutlet weak var roadMapButtonStackView: UIStackView!
    @IBOutlet weak var roadMapGoButtonFirst: UIButton!
    @IBOutlet weak var roadMapGoButtonSecond: UIButton!
    //
    //커뮤니티 button&Label
    @IBOutlet weak var communityStackView: UIStackView!
    @IBOutlet weak var communityGoButton: UIButton!
    @IBOutlet weak var boardButtonStackView: UIStackView!
    @IBOutlet weak var freeBoardGoButton: UIButton!
    @IBOutlet weak var freeBoardTextGoButton: UIButton!
    @IBOutlet weak var QnABoardGoButton: UIButton!
    @IBOutlet weak var QnABoardTextGoButton: UIButton!
    @IBOutlet weak var hotBoardGoButton: UIButton!
    @IBOutlet weak var hoeBoardTextGoButton: UIButton!
    
    //
    @IBOutlet weak var bookListTabelView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        self.setBookTableView()
        
        self.bookListTabelView.alwaysBounceVertical = false //헤더 고정 풀기
        self.setRecommendView()
        self.setCommunityView()
        self.getBookData()
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    //HomeViewController에서만 navigationBar 없애기
    //HomeViewController 뷰가 나타나기전에 hidden.true 뷰가 사라지기전에 hidden.false
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        guard let vc = storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController")as? BookDetailViewController else {return}
    //        vc.getBookDeatilData()
    //    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    private func setRecommendView(){
        self.communityStackView.layer.addBorder([.top,.bottom], color: UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1), width: 1.0)
        self.recommendButton.setTitle("추천하개 >", for: .normal)
        self.recommendButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.recommendButton.tintColor = UIColor.black
        self.recommendExplainLabel.text = "당신에게 적합한 책을 찾아 줄깨요!"
        self.recommendExplainLabel.font = UIFont.systemFont(ofSize: 12)
        self.recommendExplainLabel.textColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)
        
        self.bookynatorButtonStackView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        self.bookynatorButtonStackView.layer.borderWidth = 2
        self.bookynatorButtonStackView.layer.cornerRadius = 10
        
        self.bookynatorGoButtonFirst.setTitle("당신의 책을 찾아보세요", for: .normal)
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
    
    
    private func setCommunityView(){
        
        self.communityGoButton.setTitle("커뮤니티 >", for: .normal)
        self.communityGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        self.communityGoButton.tintColor = UIColor.black
        
        self.boardButtonStackView.layer.borderWidth = 1
        self.boardButtonStackView.layer.cornerRadius = 10
        self.boardButtonStackView.layer.borderColor = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1).cgColor
        self.freeBoardGoButton.setTitle("자유  게시판", for: .normal)
        self.freeBoardGoButton.tintColor = UIColor.black
        self.freeBoardTextGoButton.setTitle("카카오 공채 떳던데 보신분 있으 신가요 ?", for: .normal)
        self.freeBoardTextGoButton.tintColor = UIColor.black
        
        self.QnABoardGoButton.setTitle("QnA 게시판", for: .normal)
        self.QnABoardGoButton.tintColor = UIColor.black
        self.QnABoardTextGoButton.setTitle("함수를 썻는데 너무이상해요함수를 썻는데 너무이상해요함수를 썻는데 너무이상해요함수를 썻는데 너무이상해요 ", for: .normal)
        self.QnABoardTextGoButton.tintColor = UIColor.black
        
        self.hotBoardGoButton.setTitle("HoT 게시판", for: .normal)
        self.hotBoardGoButton.tintColor = UIColor.black
        self.hoeBoardTextGoButton.setTitle("한번 읽어보고 마스터한 책사실분 ?", for: .normal)
        self.hoeBoardTextGoButton.tintColor = UIColor.black
        
    }
    
    private func setBookTableView(){
        self.bookListTabelView.dataSource = self
        self.bookListTabelView.delegate = self
        
        let cellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.bookListTabelView.register(cellNib, forCellReuseIdentifier: "BookTableViewCellid")
        
        
    }
    func getBookData(){
        GetBookData.shared.getBookData(){ (sucess,data) in
            if sucess {
                guard let bookData = data as? BookInformation else {return}
                self.bookList = bookData.result.bookList
                if bookData.success{
                    DispatchQueue.main.async {
                        self.bookListTabelView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
            }
        }
    }
    @objc
    func tapAddMoreTagViewButton(sender: UIButton!){
        let deleteDecimalPoint = 230
        if cellSize == 0 {
            self.buttonText = "더보기 닫기 >"
            cellSize = CGFloat(deleteDecimalPoint)
            
        }else {
            self.buttonText = "태그 더보기>"
            cellSize = 0
            
        }
        
        self.bookListTabelView.reloadData()
        
    }
    
    @IBAction func tapCommunityGoButton(_ sender: Any) {
//루트뷰 컨트롤러 전환
//        let storyBoard = UIStoryboard(name: "Community", bundle: nil)
//        let communityViewController = storyBoard.instantiateViewController(withIdentifier: "Community")
//        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//        guard let delegate = sceneDelegate else {
//            return
//        }
//        delegate.window?.rootViewController = communityViewController
        tabBarController?.selectedIndex = 1
    }
    
  
}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 180
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 45, width: self.bookListTabelView.frame.width, height: 180))
        headerView.backgroundColor = UIColor(named: "primaryColor")
        let welComeLabel = UILabel(frame: CGRect(x: self.bookListTabelView.frame.width*(1/15), y: 45, width: self.bookListTabelView.frame.width*(2/3), height: 180))
        let noticeButton = UIButton(frame: CGRect(x: self.bookListTabelView.frame.width-60, y: 45, width: 50, height: 50))
        headerView.addSubview(welComeLabel)
        headerView.addSubview(noticeButton)
        
        welComeLabel.text = "오늘\n\(user)님에게\n추천하는 책이에요!"
     
  
        welComeLabel.adjustsFontSizeToFitWidth = true
        welComeLabel.numberOfLines = 3
        welComeLabel.font = UIFont.systemFont(ofSize: 36)
        
        welComeLabel.sizeToFit()
        welComeLabel.textColor = UIColor.white
        noticeButton.setImage(UIImage(systemName: "bell"), for: .normal)
        noticeButton.tintColor = UIColor.black
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footeriew = UIView(frame: CGRect(x: 0, y: 0, width: self.bookListTabelView.frame.width, height: 30))
        let addMoreTagViewButton = UIButton(frame: CGRect(x: self.bookListTabelView.frame.width-80, y: 0, width: 80, height: 30))
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
        cell.tableViewCellDelegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return bookList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let deleteDecimalPoint = 230
        
        if indexPath.row < 2 {
            
            return CGFloat(deleteDecimalPoint)
            
        }else {
            return cellSize
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookDetailViewSegue"{
            let BookDetailViewController = segue.destination as! BookDetailViewController
            
            BookDetailViewController.BID = self.BID
        }else if segue.identifier == "bookTagViewSegue"{
            let TagViewController = segue.destination as! TagViewController
            TagViewController.tagNameLabel?.text = "\(self.TID)"
            
        }
        
    }
}

extension HomeViewController:BookCollectionViewCellDeleGate{
    func collectionView(collectionviewcell: BookCollectionViewCell?, index: Int, didTappedInTableViewCell: BookTableViewCell) {
        self.BID = collectionviewcell?.BID ?? 0
        
        performSegue(withIdentifier: "bookDetailViewSegue", sender: self)
        //        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController") as? BookDetailViewController
        //        else {return}
        //        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController:BookTableViewCellDeleGate{
    func tapGoTagViewButton(){
//      guard let tagViewController = self.storyboard?.instantiateViewController(withIdentifier: "TagViewController") as? TagViewController else {return}
//        self.navigationController?.pushViewController(tagViewController, animated: true)
        performSegue(withIdentifier: "bookTagViewSegue", sender: self)
        
    }
}
