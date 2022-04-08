//
//  UITextField.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/06.
//

import UIKit

// MARK: - TextField Delegate
extension UITextField {
    
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
}
