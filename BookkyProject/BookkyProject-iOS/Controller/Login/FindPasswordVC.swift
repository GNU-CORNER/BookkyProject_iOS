//
//  FindPasswordVC.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/30.
//

import UIKit

class FindPasswordVC: UIViewController {

    @IBOutlet weak var findPasswordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var authenticationLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var authenticationCodeTextField: UITextField!
    
    @IBOutlet weak var requestAuthenticationCodeButton: UIButton!
    @IBOutlet weak var checkAuthenticationCodeButton: UIButton!
    @IBOutlet weak var nextStepButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setFindPasswordView()
    }
    
    func setFindPasswordView() {
        self.findPasswordLabel?.text = "PW 찾기"
        
        self.emailLabel?.text = "이메일"
        self.emailTextField?.addLeftPadding()
        self.emailTextField.layer.borderColor = .none
        self.emailTextField.layer.cornerRadius = 8.0
        self.requestAuthenticationCodeButton.setTitle("인증번호 요청", for: .normal)
        /// 수정할 것
        self.requestAuthenticationCodeButton.layer.borderColor = CGColor(red: 0.42, green: 0.58, blue: 1.00, alpha: 1.00)
        self.requestAuthenticationCodeButton.layer.borderWidth = 1.0
        self.requestAuthenticationCodeButton.layer.cornerRadius = 8.0
        
        self.authenticationLabel?.text = "인증번호"
        self.authenticationCodeTextField?.addLeftPadding()
        self.authenticationCodeTextField.layer.borderColor = .none
        self.authenticationCodeTextField.layer.cornerRadius = 8.0
        self.checkAuthenticationCodeButton.setTitle("인증번호 확인", for: .normal)
        /// 수정할 것
        self.checkAuthenticationCodeButton.layer.borderColor = CGColor(red: 0.42, green: 0.58, blue: 1.00, alpha: 1.00)
        self.checkAuthenticationCodeButton.layer.borderWidth = 1.0
        self.checkAuthenticationCodeButton.layer.cornerRadius = 8.0
        
        self.nextStepButton.setTitle("다음으로", for: .normal)
        /// 수정할 것
        self.nextStepButton.layer.borderColor = CGColor(red: 0.42, green: 0.58, blue: 1.00, alpha: 1.00)
        self.nextStepButton.layer.borderWidth = 1.0
        self.nextStepButton.layer.cornerRadius = 8.0
    }
}
