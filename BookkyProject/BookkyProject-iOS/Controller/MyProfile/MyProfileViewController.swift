//
//  MyProfileViewController.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/14.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    var userName = "이다혜"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDefaultMyProfileView()
    }
    
    func setUserImageViewCornerRadius() {
        userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
    }
    
    func setDefaultUserImage() {
        userImageView.image = UIImage(named: "북키프사")
    }
    
    func setUserNameLabel(_ userName:String) {
        userNameLabel.text = userName + "님, 반가워요!"
    }
    
    func setDefaultMyProfileView() {
        setUserImageViewCornerRadius()
        setDefaultUserImage()
        setUserNameLabel(userName)
        
    }

    @IBAction func loginTestButton(_ sender: Any) {
         //스토리보드의 파일 찾기
        let storyboard: UIStoryboard? = UIStoryboard(name: "Login", bundle: Bundle.main)

        // 스토리보드에서 지정해준 ViewController의 ID
        guard let vc = storyboard?.instantiateViewController(identifier: "LoginNavigation") else {
            return
        }

        // 화면 전환방식 선택 (default : .modal)
        vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen

        // 화면 전환!
        self.present(vc, animated: true)
    }

}
