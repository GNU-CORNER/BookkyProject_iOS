//
//  TagDataFormat.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/01.
//

import Foundation
struct TagInformation : Codable {
    let success : Bool
    let result : TagResultData
    let errorMessage : String
}
struct TagResultData : Codable {
    let bookList : TagBookList
}
struct TagBookList : Codable{
    let tag : String
    let data : [TagBookData]
}
struct TagBookData : Codable{
    let TBID : Int
    let TITLE : String
    let AUTHOR : String
    let thumbnailImage : String
    
}
