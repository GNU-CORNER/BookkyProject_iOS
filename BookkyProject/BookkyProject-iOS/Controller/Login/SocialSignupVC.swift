//
//  SocialSignupVC.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/29.
//

import UIKit

class SocialSignupVC: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var socialSignupLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var socialSignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSocialSignupView()
    }

    func setSocialSignupView() {
        self.socialSignupLabel?.text = "추가정보 입력"
        
        self.nicknameLabel?.text = "닉네임"
        self.nicknameTextField?.addLeftPadding()
        self.nicknameTextField.layer.borderColor = .none
        self.nicknameTextField.layer.cornerRadius = 8.0
        
        self.socialSignupButton.setTitle("회원가입", for: .normal)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
