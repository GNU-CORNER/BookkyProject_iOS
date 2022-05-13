//
//  CommunityViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class CommunityViewController: UIViewController {
    var boardTypeNumber : Int = 0
    let freeBoard = Free()
    let QnABoard = QnA()
    let HotBoard = Hot()
    let bookMarketBoard = BookMarket()
    let myTextBoard = Mytext()
    var PID : Int = 0
    var postListFree : [PostListData] = []
    var postListBookMarket : [PostListData] = []
    // 좋아요개수 와 댓글개수
   
    var currentPage = 1
    var getPageDataCount : Int = 0
    
    @IBOutlet var communityView: UIView!
    @IBOutlet weak var boardNameButton: UIButton!
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
    
    var moreScroll : Bool = false
    var totalTextCount : Int = 0
    var currentTextCount : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardTableView.delegate = self
        boardTableView.dataSource = self
        self.boardTableView.reloadData()
        SetdropDownView()
        //searchButton
        self.searchButton.tintColor = .black
        //writeTextButton
        setwriteTextButton()
        //초기화
        setinitCommunity()
        boardTypeColor()
        communityGetWriteList()
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
        self.boardNameButton.setTitle("자유 게시판", for: .normal)
        self.boardNameButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
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
            self.currentPage = 1
            self.postListFree = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
        }else if sender == self.bookMarketGoButton{
            self.boardTypeNumber = 1
            self.currentPage = 1
            self.postListBookMarket = []
            self.totalTextCount = 0
            self.currentTextCount = 0
            setDropDownMenu()
        }else if sender == self.QnABoardGoButton{
            self.boardTypeNumber = 2
            setDropDownMenu()
        }else if sender == self.hotBoardGobutton{
            self.boardTypeNumber = 3
            setDropDownMenu()
        }else if sender == self.myTextGoButton{
            self.boardTypeNumber = 4
            setDropDownMenu()
        }
        communityGetWriteList()
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
        
        if boardTypeNumber == 0{
            self.freeBoardGoButton.setTitleColor(.black, for: .normal)
            self.freeBoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "자유 게시판"
        }
        else if boardTypeNumber == 1 {
            self.bookMarketGoButton.setTitleColor(.black, for: .normal)
            self.bookMarketGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "책 장터 게시판"
        }else if boardTypeNumber == 2{
            self.QnABoardGoButton.setTitleColor(.black, for: .normal)
            self.QnABoardGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "Q&A 게시판"
        }else if boardTypeNumber == 3{
            self.hotBoardGobutton.setTitleColor(.black, for: .normal)
            self.hotBoardGobutton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "H🔥t 게시판"
        }else if boardTypeNumber == 4{
            self.myTextGoButton.setTitleColor(.black, for: .normal)
            self.myTextGoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            boardName = "내글 보기"
        }
        self.boardNameButton.setTitle(boardName, for: .normal)
        
    }
    private func communityGetWriteList(){
        CommunityAPI.shared.getCommunityWriteList(CommunityBoardNumber: self.boardTypeNumber,pageCount: self.currentPage) { (success,data) in
            if success{
                guard let communityGetWriteList = data as? WriteListInformation else {return}
              
                print("\(communityGetWriteList.result.postList.count)get받아오는 개수")
                self.getPageDataCount = communityGetWriteList.result.postList.count
                if self.boardTypeNumber == 0{

                    self.postListFree.append(contentsOf: communityGetWriteList.result.postList)
                }else if self.boardTypeNumber == 1 {
                    self.postListBookMarket.append(contentsOf: communityGetWriteList.result.postList)
                }
                self.totalTextCount = communityGetWriteList.result.total_size
                self.currentTextCount+=self.getPageDataCount
                if communityGetWriteList.success{
                    DispatchQueue.main.async {
                        self.boardTableView.reloadData()
                    }
                }else{
                    print("통신오류")
                }
                
            }
        }
    }
    private func beginfetch(){
        moreScroll = true
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.currentPage+=1
            self.communityGetWriteList()
            self.moreScroll = false
            self.boardTableView.reloadData()
            
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "boardTextDetailSegueId"{
            guard let boardTextDetailViewController = segue.destination as? BoardTextDetailViewController else {return}
            boardTextDetailViewController.PID = self.PID
            boardTextDetailViewController.boardTypeNumber = self.boardTypeNumber
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
        if self.boardTypeNumber == 0{
            return postListFree.count
        }else if self.boardTypeNumber == 1 {
            return postListBookMarket.count
        }else {
            return postListFree.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = boardTableView.dequeueReusableCell(withIdentifier: "boadrTableViewCellid", for: indexPath) as? BoardTableViewCell else { return UITableViewCell()}
        cell.subtittleLabel.numberOfLines = 2
        cell.subtittleLabel.font = UIFont.systemFont(ofSize: 15)
        if boardTypeNumber == 0 {
            cell.setBoardTableViewPostList(model:postListFree[indexPath.row])
        }else if boardTypeNumber == 1{
            cell.setBoardTableViewPostList(model:postListBookMarket[indexPath.row])
        }
//            else if boardTypeNumber == 2{
//            cell.setBoardTableViewPostList(model:postList[indexPath.row])
//
//        }
        //        else if boardTypeNumber == 4{
        //            cell.tittleLabel.text = myTextBoard.objectArray[indexPath.row].title
        //            cell.subtittleLabel.text = myTextBoard.objectArray[indexPath.row].subtitle
        //        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? BoardTableViewCell else {return}
        self.PID = cell.PID
        performSegue(withIdentifier: "boardTextDetailSegueId", sender: indexPath.row)
    }
    //무한스크롤
    //스크롤 될때마다 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let totalScrollSize = scrollView.contentSize.height - scrollView.bounds.height
        let scrollSize = scrollView.contentOffset.y+50
        if currentTextCount < totalTextCount  {
            if  scrollSize > totalScrollSize{
                if !moreScroll {
                    print("로딩실행")
                    beginfetch()
                }
                
            }
            
        }
       
    }
    
}
