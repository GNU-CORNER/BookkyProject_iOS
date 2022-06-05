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
class ReviewButton : UIButton {
    var RID : Int = 0
    var isAccessible : Bool = false
    var contents : String = ""
    var rating : Float = 0.0
    convenience init(RID : Int ,isAccessible : Bool,contents : String , rating : Float) {
        self.init()
        self.RID = RID
        self.isAccessible = isAccessible
        self.contents = contents
        self.rating = rating
    }
}
