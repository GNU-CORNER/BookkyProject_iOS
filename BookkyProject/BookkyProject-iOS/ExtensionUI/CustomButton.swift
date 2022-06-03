//
//  CustomButton.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/06/02.
//

import Foundation
import UIKit
class CustomButton : UIButton {
    var section : Int = 0
    var CID : Int = 0
    var isAccessible : Bool = false
    convenience init(section: Int,CID : Int, isAccessible : Bool) {
        self.init()
        self.section = section
        self.CID = CID
        self.isAccessible = isAccessible
        }
}
class ImageCancelButton : UIButton {
    var row : Int = 0
    convenience init(row: Int) {
        self.init()
        self.row = row
        }
}
