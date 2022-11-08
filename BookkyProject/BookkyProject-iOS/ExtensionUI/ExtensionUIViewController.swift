//
//  ExtensionUIViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/10/21.
//

import Foundation
import UIKit
extension UIViewController {
    // MARK: - 임시방법
    func errorNetWork(){
        DispatchQueue.main.async {
            let errNetWork = UIAlertController(title: "네트워크 오류입니다.", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .default){(_)in
              
            }
            errNetWork.addAction(cancel)
            self.present(errNetWork, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.tabBarController?.selectedIndex = 0
        })
        
    }
    //ATtokenRefrech 대체 -임시 방법
//    func boardDetailNetError(){
//        DispatchQueue.main.async {
//            let netError = UIAlertController(title: "네트워크 오류입니다.", message: "", preferredStyle: .alert)
//            let cancel = UIAlertAction(title: "취소", style: .cancel)
//            netError.addAction(cancel)
//            self.present(netError, animated: true)
//
//        }
//    }

    func keyboardDown(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismisskeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismisskeyboard(){
        view.endEditing(true)
    }
// 코드 출처 :https://icksw.tistory.com/87
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
//    @objc func keyboardWillShow(_ noti: NSNotification){
//        // 키보드의 높이만큼 화면을 올려준다.
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            let screenHeiht = UIScreen.main.bounds.size.height
//            self.view.window?.frame.origin.y -= (keyboardHeight-(screenHeiht*1/10))
//        }
//    }
//
//    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
//    @objc func keyboardWillHide(_ noti: NSNotification){
//        // 키보드의 높이만큼 화면을 내려준다.
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            let screenHeiht = UIScreen.main.bounds.size.height
//            self.view.window?.frame.origin.y += (keyboardHeight-(screenHeiht*1/10))
//
//        }
//    }
//
//    // 노티피케이션을 추가하는 메서드
//    func addKeyboardNotifications(){
//        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
//        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//
//    // 노티피케이션을 제거하는 메서드
//    func removeKeyboardNotifications(){
//        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
//        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
}
