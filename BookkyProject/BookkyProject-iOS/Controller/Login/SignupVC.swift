//
//  SignupVC.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/03/29.
//

import UIKit

class SignupVC: UIViewController {
    
    @IBOutlet weak var signupLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailAuthenticateTimeLabel: UILabel!
    @IBOutlet weak var emailCheckLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordCheckLabel: UILabel!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailCheckTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailAuthenticationRequestButton: UIButton!
    @IBOutlet weak var emailCheckButton: UIButton!
    
    var emailTimeoutFlag: Bool = true
    var timer: Timer?
    var totalSecond: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setSignupView()
        setTextFieldDelgate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timerReset()
    }
    
    func setSignupView() {
        self.signupLabel?.text = "회원가입"
        
        self.nicknameLabel?.text = "닉네임"
        self.nicknameTextField?.addLeftPadding()
        self.nicknameTextField.layer.borderColor = .none
        self.nicknameTextField.layer.cornerRadius = 8.0
        
        self.emailLabel?.text = "이메일"
        self.emailTextField?.addLeftPadding()
        self.emailTextField.layer.borderColor = .none
        self.emailTextField.layer.cornerRadius = 8.0
        self.emailAuthenticationRequestButton.layer.borderColor = .none
        self.emailAuthenticationRequestButton.layer.cornerRadius = 8.0
        /// 이메일이 양식에 맞게 입력이 되면 (혹은 텍스트 필드에 무엇인가 입력이 되면) true가 되도록
        self.emailAuthenticationRequestButton.isEnabled = false
        
        self.emailAuthenticateTimeLabel.isHidden = true
        
        self.emailCheckLabel?.text = "이메일 확인"
        self.emailCheckTextField?.addLeftPadding()
        self.emailCheckTextField.layer.borderColor = .none
        self.emailCheckTextField.layer.cornerRadius = 8.0
        /// 이메일 요청을 보내면 그때 활성화 되도록..
//        self.emailCheckTextField.isEnabled = false
        self.emailCheckButton.layer.borderColor = .none
        self.emailCheckButton.layer.cornerRadius = 8.0
        /// 이메일 요청을 보내면 그때 활성화 되도록..
        self.emailCheckButton.isEnabled = false
        
        self.passwordLabel?.text = "비밀번호"
        self.passwordTextField.isSecureTextEntry = true
        self.passwordTextField?.addLeftPadding()
        self.passwordTextField.layer.borderColor = .none
        self.passwordTextField.layer.cornerRadius = 8.0
        
        self.passwordCheckLabel?.text = "비밀번호 확인"
        self.passwordCheckTextField.isSecureTextEntry = true
        self.passwordCheckTextField?.addLeftPadding()
        self.passwordCheckTextField.layer.borderColor = .none
        self.passwordCheckTextField.layer.cornerRadius = 8.0
        
        self.signupButton.setTitle("회원가입", for: .normal)
    }
    
    // 코드 확인 필요
    func showToast(message : String) {
        let toastLabel = UILabel(
            frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height - 180, width: 300, height: 35)
        )
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 6.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {
            (isCompleted) in toastLabel.removeFromSuperview()
        })
    }
    
    func timerReset() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }

    // - [x] 이메일 형식 확인 절차
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print("이메일 형식 확인")
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func emailAuthenticateRequest(_ sender: Any) {
        print("버튼클릭")
        // - [x] 타이머 리셋 (버튼을 다시 누를 경우도 생기기 때문..)
        timerReset()
        // - [x] 이메일 형식이 맞는지 확인
        guard let emailText = self.emailTextField?.text else { return }
        if isValidEmail(testStr: emailText) {
            print("이메일 형식 통과")
            self.emailTextField.layer.borderWidth = 0
            // - [x] 3분 타이머 실행
            totalSecond = 180
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ThreeMinutesTimer), userInfo: nil, repeats: true)
            // - [x] 서버로 이메일 인증 요청
            if let userEmail = self.emailTextField?.text as? String {
                requestEmailAuth(email: userEmail)
            }
            // - [x] 본인의 이메일로 인증번호 확인 부탁한다는 토스트 메시지 띄우기
            showToast(message: "해당 이메일로 인증번호를 보냈습니다.")
        } else {
            print("이메일 형식이 맞지 않아요!")
            // - [x] 토스트 메시지 "이메일 형식이 맞지 않습니다"
            showToast(message: "이메일 형식이 맞지 않습니다.")
            // - [x] 이메일 입력칸에 빨간 테두리로 경고
            self.emailTextField.layer.borderWidth = 1.0
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            UIView.animate(withDuration: 3.0, animations: {
                self.emailTextField.layer.borderWidth = 0
            })
            
        }
        
    }
    
    func requestEmailAuth(email: String) {
        EmailAuthenticate.shared.authenticateCodeSender(userEmail: email) { (success, data) in
            if success {
                guard let resultData = data as? EmailAuthModel else { return }
                print(resultData)
                print(resultData.success)
                print(resultData.result.email)
            } else {
                print("통신실패 ㅠ")
            }
        }
    }
    
    @objc func ThreeMinutesTimer() {
        // - [x] 3분 타이머 실행
        let second: Int = totalSecond % 60
        let minute: Int = totalSecond / 60
        self.emailAuthenticateTimeLabel.isHidden = false
        self.emailAuthenticateTimeLabel?.text = String(format: "%2d:%02d", minute, second)
        print("타이머 실행!")
        if totalSecond > 0 {
            totalSecond -= 1
        } else {
            if let timer = self.timer {
                self.emailAuthenticateTimeLabel?.text = "시간 초과"
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
}

extension SignupVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.emailTextField.isEditing {
            print("이메일 텍스트 입력중")
            self.emailAuthenticationRequestButton.isEnabled = true
//            self.emailAuthenticationRequestButton.setTitleColor(.white, for: .normal)
            self.emailAuthenticationRequestButton.backgroundColor = UIColor(named: "PrimaryColor")
        } else if self.emailCheckTextField.isEditing {
            print("이메일 체크 텍스트 입력중")
        } else { return }
    }
    
    func setTextFieldDelgate() {
        self.emailTextField.delegate = self
        self.emailCheckTextField.delegate = self
    }
    
}
