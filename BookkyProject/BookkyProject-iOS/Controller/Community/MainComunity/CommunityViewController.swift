//
//  CommunityViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class CommunityViewController: UIViewController {
    
    var previousBoardNumber : Int = 0 // 현재 게시판
    var boardTypeNumber : Int = 0 // 데이터를 받아오는 게시판 번호
    var PID : Int = 0
    var postListFree : [PostListData] = []
    var postListBookMarket : [PostListData] = []
    var postListQnA : [PostQnAListData] = []
    var myPostList : [PostLisyMyList] = []
    var hotPostList : [PostListHotList] = []
    // 좋아요개수 와 댓글개수
    var currentPage = 1
    var getPageDataCount : Int = 0
    @IBOutlet var communityView: UIView!
    @IBOutlet weak var boardNameButton: UIButton!
    @IBOutlet weak var boardNameLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var writeTextButton: UIButton!
    @IBOutlet weak var freeBoardGoButton: UIButton!
    @IBOutlet weak var hotBoardGobutton: UIButton!
    @IBOutlet weak var QnABoardGoButton: UIButton!
    @IBOutlet weak var bookMarketGoButton: UIButton!
    @IBOutlet weak var myTextGoButton: UIButton!
    @IBOutlet weak var boardTypeStackView: UIStackView!
    //tableView
    @IBOutlet weak var boardTableView: UITableView!
    @IBOutlet weak var grayView: UIView!
    var moreScroll : Bool = true
    var totalTextCount : Int = 0
    var currentTextCount : Int = 0
    //replyCnt. -1 일반글 갯수 있으면 Q&A글
    var replyCnt : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.boardTableView.delegate = self
        self.boardTableView.dataSource = self
        self.SetQnACell()
        SetdropDownView()
        //searchButton
        self.searchButton?.tintColor = .black
        //writeTextButton
        self.setwriteTextButton()
        //초기화
        setinitCommunity()
        boardTypeColor()
    }
    func SetdropDownView(){
        self.freeBoardGoButton.setTitle("자유", for: .normal)
        self.hotBoardGobutton.setTitle("HOT", for: .normal)
        self.QnABoardGoButton.setTitle("Q&A", for: .normal)
        self.bookMarketGoButton.setTitle("책 장터", for: .normal)
        self.myTextGoButton.setTitle("내 글 보기", for: .normal)
    }
    func setinitCommunity(){
        //보드게시판 클릭전 초기
        self.boardNameLabel?.text = "자유 게시판"
        self.boardNameButton?.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        self.boardNameButton.sizeToFit()
        self.boardNameButton.tintColor = .black
        self.freeBoardGoButton.setTitleColor(.black, for: .normal)
    }
    private func setwriteTextButton(){
        self.writeTextButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        self.writeTextButton.setTitle("글쓰기 ", for: .normal)
        self.writeTextButton.setPreferredSymbolConfiguration(.init(pointSize: 15, weight: .regular, scale: .default), forImageIn: .normal)
        self.writeTextButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.writeTextButton.backgroundColor = UIColor(named: "primaryColor")
        self.writeTextButton.sizeToFit()
        self.writeTextButton.tintColor = .white
        self.writeTextButton.layer.borderWidth = 2
        self.writeTextButton.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        self.writeTextButton.layer.cornerRadius = 8
        
        
        self.boardTypeStackView.layer.borderWidth = 2
        self.boardTypeStackView.layer.borderColor = UIColor.white.cgColor
        self.boardTypeStackView.layer.cornerRadius = 10
        self.boardTypeStackView.sizeToFit()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setDropDownMenu()
        self.updateTableView()
        
    }
    func updateTableView(){
        if self.previousBoardNumber == 0  {
            self.boardNameLabel.text = "자유 게시판"
            self.boardTypeNumber = 0
            self.previousBoardNumber = 0
            self.currentPage = 1
            self.postListFree = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostList()
        }else if self.previousBoardNumber == 1 {
            self.boardNameLabel.text = "책장터 게시판"
            self.boardTypeNumber = 1
            self.previousBoardNumber = 1
            self.currentPage = 1
            self.postListBookMarket = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostList()
        }else if self.previousBoardNumber == 2 {
            self.boardNameLabel.text = "Q&A 게시판"
            self.boardTypeNumber = 2
            self.previousBoardNumber = 2
            self.currentPage = 1
            self.postListQnA = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostQnAList()
        }else if self.previousBoardNumber == 3 {
            self.boardNameLabel.text = "내글 보기"
            self.boardTypeNumber = 3
            self.previousBoardNumber = 3
            self.currentPage = 1
            self.myPostList = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostMyList()
        }else if self.previousBoardNumber == 4 {
            self.boardNameLabel.text = "H🔥t 게시판"
            self.boardTypeNumber = 4
            self.previousBoardNumber = 4
            self.currentPage = 1
            self.hotPostList = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostHotList()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(animated)
    //
    //
    //    }
    
    private func boardTypeColor() {
        self.freeBoardGoButton.tintColor = UIColor(named: "grayColor")
        self.hotBoardGobutton.tintColor = UIColor(named: "grayColor")
        self.QnABoardGoButton.tintColor = UIColor(named: "grayColor")
        self.bookMarketGoButton.tintColor = UIColor(named: "grayColor")
        self.myTextGoButton.tintColor = UIColor(named: "grayColor")
    }
    
    //드롭다운 메뉴구현
    @IBAction func tapGoBoard(_ sender: UIButton) {
        if sender == self.freeBoardGoButton{
            self.boardTypeNumber = 0
            self.previousBoardNumber = 0
            self.currentPage = 1
            self.postListFree = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostList()
        }else if sender == self.bookMarketGoButton{
            self.boardTypeNumber = 1
            self.previousBoardNumber = 1
            self.currentPage = 1
            self.postListBookMarket = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostList()
        }else if sender == self.QnABoardGoButton{
            self.boardTypeNumber = 2
            self.previousBoardNumber = 2
            self.currentPage = 1
            self.postListQnA = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostQnAList()
        }else if sender == self.myTextGoButton{
            self.boardNameLabel.text = "내글 보기"
            self.boardTypeNumber = 3
            self.previousBoardNumber = 3
            self.currentPage = 1
            self.myPostList = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostMyList()
        }else if sender == self.hotBoardGobutton{
            self.boardTypeNumber = 4
            self.previousBoardNumber = 4
            self.currentPage = 1
            self.hotPostList = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
            communityGetPostHotList()
        }
        
        self.boardTableView.reloadData()
    }
    
    @IBAction func tapChangeBoard(_ sender: UIButton) {
        if boardTypeStackView.isHidden == false {
            self.boardTypeStackView.isHidden = true
            self.grayView.isHidden = true
            self.boardTableView.backgroundColor = .white
        }else{
            self.boardTypeStackView.isHidden = false
            self.grayView.isHidden = false
            self.boardTypeStackView.backgroundColor = .white
            self.communityView.bringSubviewToFront(self.grayView)
            self.communityView.bringSubviewToFront(self.boardTypeStackView)
        }
        self.boardTableView.reloadData()
    }
    //드롭다운을 위한 메소드
    func setDropDownMenu(){
        var boardName : String = "자유 게시판"
        self.freeBoardGoButton.setTitleColor(.gray, for: .normal)
        self.hotBoardGobutton.setTitleColor(.gray, for: .normal)
        self.QnABoardGoButton.setTitleColor(.gray, for: .normal)
        self.bookMarketGoButton.setTitleColor(.gray, for: .normal)
        self.myTextGoButton.setTitleColor(.gray, for: .normal)
        
        self.freeBoardGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.hotBoardGobutton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.QnABoardGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.bookMarketGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.myTextGoButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.boardTypeStackView.isHidden = true
        self.grayView.isHidden = true
        self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        
        if previousBoardNumber == 0{
            self.freeBoardGoButton.setTitleColor(.black, for: .normal)
            self.freeBoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "자유 게시판"
        }
        else if previousBoardNumber == 1 {
            self.bookMarketGoButton.setTitleColor(.black, for: .normal)
            self.bookMarketGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "책장터 게시판"
        }else if previousBoardNumber == 2{
            self.QnABoardGoButton.setTitleColor(.black, for: .normal)
            self.QnABoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "Q&A 게시판"
        }else if previousBoardNumber == 4{
            self.hotBoardGobutton.setTitleColor(.black, for: .normal)
            self.hotBoardGobutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "H🔥t 게시판"
        }else if previousBoardNumber == 3{
            self.myTextGoButton.setTitleColor(.black, for: .normal)
            self.myTextGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "내글 보기"
        }
        self.boardNameLabel.text = boardName
        
    }
    private func SetQnACell(){
        let cellNib = UINib(nibName: "QnABoardTableViewCell", bundle: Bundle(for: QnABoardTableViewCell.self))
        self.boardTableView.register(cellNib, forCellReuseIdentifier: "QnATableVIewCellid")
    }
    
    func communityGetPostList(){
        CommunityGetAPI.shared.getCommunityWriteList(CommunityBoardNumber: self.previousBoardNumber,pageCount: self.currentPage) { (success,data) in
            if success{
                guard let communityGetWriteList = data as? WriteListInformation else {return}
                if self.boardTypeNumber == 0{
                    self.postListFree.append(contentsOf: communityGetWriteList.result.postList)
                }else if self.boardTypeNumber == 1  {
                    self.postListBookMarket.append(contentsOf: communityGetWriteList.result.postList)
                }
                self.getPageDataCount = communityGetWriteList.result.postList.count
                self.totalTextCount = communityGetWriteList.result.total_size
                self.currentTextCount+=self.getPageDataCount
                print("\(communityGetWriteList.result.postList.count)get받아오는 개수")
                if communityGetWriteList.success{
                    DispatchQueue.main.async {
                        self.boardTableView.reloadData()
                    }
                }else{
                    print("통신오류")
                }
                self.moreScroll = true
            }
        }
        
    }
    func communityGetPostHotList(){
        CommunityGetAPI.shared.getCommunityPostListHot { (sucess,data ) in
            if sucess {
                guard let PostHotList = data as? PostListHotInformation else {return}
                self.hotPostList.append(contentsOf: PostHotList.result.postList)
                self.getPageDataCount = PostHotList.result.postList.count
                self.totalTextCount = PostHotList.result.total_size
                self.currentTextCount+=self.getPageDataCount
                if PostHotList.success{
                    DispatchQueue.main.async {
                        self.boardTableView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
                self.moreScroll = true
            }
        }
        
    }
    
    func communityGetPostQnAList(){
        CommunityGetAPI.shared.getCommunityWriteQnAList(CommunityBoardNumber: self.previousBoardNumber,pageCount: self.currentPage) { (success,data) in
            if success{
                guard let communityGetWriteQnAList = data as? WriteListQnAInformation else {return}
                self.postListQnA.append(contentsOf: communityGetWriteQnAList.result.postList)
                self.getPageDataCount = communityGetWriteQnAList.result.postList.count
                self.totalTextCount = communityGetWriteQnAList.result.total_size
                self.currentTextCount+=self.getPageDataCount
                if communityGetWriteQnAList.success{
                    DispatchQueue.main.async {
                        self.boardTableView.reloadData()
                    }
                }else{
                    print("통신오류")
                }
                self.moreScroll = true
                
            }
        }
    }
    func communityGetPostMyList(){
        CommunityGetAPI.shared.getCommunityMyWriteList(CommunityBoardNumber: self.previousBoardNumber, pageCount: self.currentPage) { (success,data) in
            if success {
                guard let communityGetWriteMyList = data as? PostListMyInformation else {return}
                self.myPostList.append(contentsOf: communityGetWriteMyList.result.postList)
                self.getPageDataCount = communityGetWriteMyList.result.postList.count
                self.totalTextCount = communityGetWriteMyList.result.total_size
                self.currentTextCount+=self.getPageDataCount
                if communityGetWriteMyList.success{
                    DispatchQueue.main.async {
                        self.boardTableView.reloadData()
                    }
                }else{
                    print("통신오류")
                }
                self.moreScroll = true
            }
        }
    }
   
    private func beginfetch(){
        self.moreScroll = false
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.currentPage+=1
            if self.previousBoardNumber == 0{
                self.communityGetPostList()
            }else if self.previousBoardNumber == 1{
                self.communityGetPostList()
            }else if self.previousBoardNumber == 2 {
                self.communityGetPostQnAList()
            }else if self.previousBoardNumber == 3{
                self.communityGetPostMyList()
            }else if self.previousBoardNumber == 4{
                self.communityGetPostHotList()
            }else {
                self.communityGetPostList()
            }
            self.boardTableView.reloadData()
            
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "boardTextDetailSegueId"{
            guard let boardTextDetailViewController = segue.destination as? BoardTextDetailViewController else {return}
            boardTextDetailViewController.PID = self.PID
            boardTextDetailViewController.previousBoardNumber = self.previousBoardNumber
            boardTextDetailViewController.boardTypeNumber = self.boardTypeNumber
        }else if segue.identifier == "QnAboardTextDetailSegueId"{
            guard let QnABoardTextDetailViewController = segue.destination as? QnABoardTextDetailViewController else {return}
            QnABoardTextDetailViewController.PID = self.PID
            QnABoardTextDetailViewController.boardTypeNumber = self.boardTypeNumber
        }
        
    }
    
}
extension CommunityViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.previousBoardNumber == 0{
            return postListFree.count
        }else if self.previousBoardNumber == 1 {
            return postListBookMarket.count
        }else if self.previousBoardNumber == 2 {
            return postListQnA.count
        }else if self.previousBoardNumber == 3{
            return myPostList.count
        }else if self.previousBoardNumber == 4 {
            return self.hotPostList.count
        }else{
            return postListFree.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = boardTableView.dequeueReusableCell(withIdentifier: "boadrTableViewCellid", for: indexPath) as? BoardTableViewCell else { return UITableViewCell()}
        guard let QnACell = boardTableView.dequeueReusableCell(withIdentifier: "QnATableVIewCellid", for: indexPath) as? QnABoardTableViewCell else { return UITableViewCell()}
        if previousBoardNumber == 0 {
            cell.setBoardPostList(model:postListFree[indexPath.row])
            return cell
        }
        else if previousBoardNumber == 1{
            cell.setBoardPostList(model:postListBookMarket[indexPath.row])
            return cell
        }
        else if previousBoardNumber == 2{
            QnACell.setBoardPostQnAList(model: postListQnA[indexPath.row])
            return QnACell
        }
        else if previousBoardNumber == 3{
            if myPostList[indexPath.row].communityType == 2{
                QnACell.setBoardPostmyList(model: myPostList[indexPath.row])
                return QnACell
            }else {
                cell.setBoardMyPostList(model: myPostList[indexPath.row])
                return cell
            }
        }
        else if previousBoardNumber == 4{
            if hotPostList[indexPath.row].communityType == 2{
                QnACell.setBoardPostHotList(model: hotPostList[indexPath.row])
                return QnACell
            }else {
                cell.setBoardHotPostList(model: hotPostList[indexPath.row])
                return cell
            }
            
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.previousBoardNumber == 2 {
            guard let QnACell = tableView.cellForRow(at: indexPath) as? QnABoardTableViewCell else {return}
            self.PID = QnACell.PID
            performSegue(withIdentifier: "QnAboardTextDetailSegueId", sender: indexPath.row)
        }else if self.previousBoardNumber == 3{
            self.replyCnt = self.myPostList[indexPath.row].replyCnt
            if self.replyCnt == -1 {
                guard let cell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {return }
                self.previousBoardNumber = 3
                self.PID = cell.PID
                self.boardTypeNumber = cell.communityType
                performSegue(withIdentifier: "boardTextDetailSegueId", sender: indexPath.row)
            }else {
                guard let QnACell = tableView.cellForRow(at: indexPath) as? QnABoardTableViewCell else {return}
                self.previousBoardNumber = 3
                self.PID = QnACell.PID
                self.boardTypeNumber = QnACell.communityType
                performSegue(withIdentifier: "QnAboardTextDetailSegueId", sender: indexPath.row)
            }
        }else if self.previousBoardNumber == 4{
            self.replyCnt = self.hotPostList[indexPath.row].replyCnt
            if self.replyCnt == -1 {
                guard let cell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {return }
                self.previousBoardNumber = 4
                self.PID = cell.PID
                self.boardTypeNumber = cell.communityType
                performSegue(withIdentifier: "boardTextDetailSegueId", sender: indexPath.row)
            }else {
                guard let QnACell = tableView.cellForRow(at: indexPath) as? QnABoardTableViewCell else {return}
                self.previousBoardNumber = 4
                self.PID = QnACell.PID
                self.boardTypeNumber = QnACell.communityType
                performSegue(withIdentifier: "QnAboardTextDetailSegueId", sender: indexPath.row)
            }
        }else {
            guard let cell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {return }
            self.PID = cell.PID
            performSegue(withIdentifier: "boardTextDetailSegueId", sender: indexPath.row)
        }
    }
    //무한스크롤
    //스크롤 될때마다
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let totalScrollSize = scrollView.contentSize.height - scrollView.bounds.height
        let scrollSize = scrollView.contentOffset.y+50
        if currentTextCount < totalTextCount  {
            if  scrollSize > totalScrollSize{
                if moreScroll {
                    print("로딩실행")
                    beginfetch()
                }
            }
        }
    }
}
