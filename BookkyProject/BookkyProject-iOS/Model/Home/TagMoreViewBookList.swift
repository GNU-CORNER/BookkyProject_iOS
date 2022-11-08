//
//  TagMoreViewBookList.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/12.
//

import Foundation
struct TagMoreViewBookInformation : Codable {
    let success : Bool
    let result : TagMoreViewBookListData?
    let errorMessage : String?
}
struct TagMoreViewBookListData : Codable {
    let bookList : [TagmoreViewBookList]?
    let nickname : String?
}
struct TagmoreViewBookList : Codable {
    let tag : String
    let TMID : Int?
    let data : [TagMoreViewBookData]
}
struct TagMoreViewBookData : Codable {
    let TBID : Int
    let TITLE : String
    let AUTHOR: String
    let thumbnailImage : String
    let RATING : Double
}
