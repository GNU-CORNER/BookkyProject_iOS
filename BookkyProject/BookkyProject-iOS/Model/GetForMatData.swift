//
//  GetForMatData.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//

import Foundation
struct BookInformation : Codable {
    let success : Bool
    let result : ResultData
    let errorMessage : String
}
struct ResultData : Codable {
    let bookList : [BookList]
    let communityList : [Int]
    let userData : UserData
}
struct UserData : Codable{
    let UID : Int
    let tag_array : [Int]
    let nickname : String
    let thumbnail : String
}
struct BookList : Codable{
    //    let success : Bool
    
    let tag : String
    let data : [BookData]
    
}
struct BookData : Codable{
    let BID : Int
    let TITLE : String
    let AUTHOR: String
    let thumbnailImage : String
    //    let SUBTITLE: String

    //    let ISBN: String
    //    let PUBLISHER: String
    //    let PRICE: String
    //    let PAGE: String
    //    let BOOK_INDEX: String
    //    let BOOK_INTRODUCTION: String
    //    let PUBLISH_DATE: String
    //    let Allah_BID: String
}


