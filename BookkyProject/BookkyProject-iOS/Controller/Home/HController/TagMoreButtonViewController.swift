//
//  TagMoreButtonViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/11.
//

import UIKit

class TagMoreButtonViewController: UIViewController,UICollectionViewDelegate{
    var userName = "사용자"
    var buttonText = "태그 더보기>"
    var bookList : [TagmoreViewBookList] = []
    var BID : Int = 0
    var TID : Int = 0
    @IBOutlet weak var navigationBarRightButton: UIBarButtonItem!
    @IBOutlet weak var tagMoreBookListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setBookListTableView()
        setView()
        statusBarView?.backgroundColor = UIColor(named:"primaryColor")
    }
    public func setView() {
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
            print("MyProfile: 사용자 이메일을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        guard let acessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) else {
            print("MyProfile: 토큰을 불러올 수 없음.")
            RedirectView.loginView(previousView: self)
            return
        }
        self.getTagViewBookData(accessToken: acessToken)
    }
    //MARK: - 상태바
    private func setNavigationBar(){
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.backgroundColor = UIColor(named: "PrimaryBlueColor")
        self.navigationBarRightButton.tintColor = UIColor.black
    }
    private func setBookListTableView(){
        self.tagMoreBookListTableView.alwaysBounceVertical = false //헤더 고정 풀기
        self.tagMoreBookListTableView.delegate = self
        self.tagMoreBookListTableView.dataSource = self
        let cellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        self.tagMoreBookListTableView.register(cellNib, forCellReuseIdentifier: "BookTableViewCellid")
    }
    private func getTagViewBookData(accessToken:String){
        GetBookData.shared.getTagMoreViewBookData(accessToken:accessToken){ (sucess,data,statusCode) in
            guard let bookData = data as? TagMoreViewBookInformation else {return}
            if sucess {
                self.bookList = (bookData.result?.bookList)!
                self.userName = (bookData.result?.nickname)!
                if bookData.success{
                    DispatchQueue.main.async {
                        self.tagMoreBookListTableView.reloadData()
                    }
                }else {
                    print("통신 오류")
                }
            }else{
                if let errMessage = bookData.errorMessage{
                    print("Home request fasle:\(errMessage)")
                }
                print("request Home: false")
                if statusCode == 401 {
                    // 새로 AT 갱신할 것.
                    // 만료된 토큰입니다. RefreshToken의 기간이 지남
                    print(statusCode)
                    if let errorMessage = bookData.errorMessage {
                        print("request Book false의 이유: \(errorMessage)")
                    }
                    
                    guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsModel.email.rawValue) else {
                        print("사용자 이메일을 불러올 수 없음.")
                        return
                    }
                    guard let previousAccessToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue),
                          let previousRefreshToken = KeychainManager.shared.read(userEmail: userEmail, itemLabel: UserDefaultsModel.refreshToken.rawValue) else {
                        print("토큰을 불러올 수 없음.")
                        return
                    }
                    print("갱신요청")
                    Account.shared.refreshAuth(accessToken: previousAccessToken, refreshToken: previousRefreshToken) { (success, data, statuscode) in
                        guard let tokens = data as? RefreshModel else { return }
                        if success {
                            if let newAccessToken = tokens.result?.accessToken {
                                if !KeychainManager.shared.update(newAccessToken, userEmail: userEmail, itemLabel: UserDefaultsModel.accessToken.rawValue) {
                                    print("새로운 토큰 제대로 저장이 안되었어요~~~~")
                                }
                                print("getAT")
                                self.getTagViewBookData(accessToken: newAccessToken)
                            }
                        } else {
                            print(statuscode)
                            if statuscode == 400 {
                                // 유효한 토큰입니다. AccessToken의 만료기간이 남음
                                print(tokens.errorMessage)
                            } else if statuscode == 401 {
                                // 만료된 토큰입니다.
                                print(tokens.errorMessage)
                                RedirectView.loginView(previousView: self)
                            } else if statuscode == 403 {
                                // 유효하지 않은 토큰입니다. RefreshToken의 형식이 잘못됨
                                // 로그인 화면 리다이렉트
                                RedirectView.loginView(previousView: self)
                            }
                        }
                    }
                    
                }
                
                
            }
            
        }
    }
}

extension TagMoreButtonViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tagMoreBookListTableView.frame.width, height: 120))
        headerView.backgroundColor = UIColor(named: "primaryColor")
        let welComeLabel = UILabel(frame: CGRect(x: self.tagMoreBookListTableView.frame.width*(1/15), y: 20, width: self.tagMoreBookListTableView.frame.width*(2/3), height: 120))
        headerView.addSubview(welComeLabel)
        welComeLabel.text = "북키가\n\(self.userName)님에게\n추천하는 책이에요!"
        welComeLabel.adjustsFontSizeToFitWidth = true
        welComeLabel.numberOfLines = 3
        welComeLabel.font = UIFont.systemFont(ofSize: 24)
        welComeLabel.sizeToFit()
        welComeLabel.textColor = UIColor.white
        welComeLabel.asColr(targetString: userName, color: .black)
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:BookTableViewCell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCellid", for: indexPath) as? BookTableViewCell else { return UITableViewCell()}
        cell.setTagMoreViewInformation(model: bookList[indexPath.row])
        cell.cellDelegate = self
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TagMoreBookDetailViewSegue"{
            let BookDetailViewController = segue.destination as! BookDetailViewController
            BookDetailViewController.BID = self.BID
        }else if segue.identifier == "TagMoreBookTagViewSegue"{
            guard let tagViewController = segue.destination as? TagViewController else {return}
            tagViewController.TID = self.TID
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? BookTableViewCell else {return}
        self.TID = cell.TID
        print("\(self.TID)")
        performSegue(withIdentifier: "TagMoreBookTagViewSegue", sender: indexPath.row)
    }
    
}
extension TagMoreButtonViewController : BookCollectionViewCellDeleGate{
    func collectionView(collectionviewcell: BookCollectionViewCell?, index: Int, didTappedInTableViewCell: BookTableViewCell) {
        self.BID = collectionviewcell?.BID ?? 0
        
        performSegue(withIdentifier: "TagMoreBookDetailViewSegue", sender: self)
    }
    
    
}
