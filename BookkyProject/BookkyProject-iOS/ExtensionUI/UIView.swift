//
//  UIView.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/08/09.
//

import UIKit

extension UIView {
    
    // UIView에 그림자 생성
    func applyShadow(cornerRadius: CGFloat) {
        layer.shadowRadius = cornerRadius
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
}
