//
//  ExtensionUIViewController.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/10/21.
//

import Foundation
import UIKit
extension UIViewController {
    func keyboardDown(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismisskeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismisskeyboard(){
        view.endEditing(true)
    }
}
