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
    var contents : String = ""
    var isAccessible : Bool = false
    convenience init(section: Int,CID : Int, isAccessible : Bool,contents: String) {
        self.init()
        self.section = section
        self.CID = CID
        self.isAccessible = isAccessible
        self.contents = contents
        }
}
class ImageCancelButton : UIButton {
    var row : Int = 0
    convenience init(row: Int) {
        self.init()
        self.row = row
        }
}
class CommentLikeButton : UIButton {
    var CoomentCID : Int = 0
    convenience init(CoomentCID: Int) {
        self.init()
        self.CoomentCID = CoomentCID
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
