//
//  ButtonPadding.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/02.
//

import Foundation
import UIKit
class AutoAddPaddingButtton : UIButton
{
    override var intrinsicContentSize: CGSize {
       get {
           let baseSize = super.intrinsicContentSize
           return CGSize(width: baseSize.width + 20,//ex: padding 20
                         height: baseSize.height)
           }
    }
}
