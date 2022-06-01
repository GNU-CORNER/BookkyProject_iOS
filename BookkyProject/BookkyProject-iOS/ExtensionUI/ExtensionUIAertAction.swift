//
//  ExtensionUIAertAction.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/01.
//

import Foundation
import UIKit
// alert Text색상 설정
extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
