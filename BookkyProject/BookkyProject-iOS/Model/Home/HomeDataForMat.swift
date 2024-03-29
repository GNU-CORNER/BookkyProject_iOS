//
//  GetForMatData.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/09.
//
//Home
import Foundation
struct BookInformation : Codable {
    let success : Bool
    let result : ResultData?
    let errorMessage : String?
}
struct ResultData : Codable {
    let bookList : [BookList]?
    let userData : HomeUserData?
    let communityList : [CommunityRecentList]?
}
struct CommunityRecentList : Codable {
    let title : String
    let updateAt : String
    let PID : Int
    let communityType : Int
}
struct HomeUserData : Codable{
    let UID  : Int
    let nickname : String
    let thumbnail : String?
}
struct BookList : Codable{
    let tag : String
    let TMID : Int?
    let data : [BookData]
}
struct BookData : Codable{
    let TBID : Int
    let TITLE : String
    let AUTHOR: String
    let thumbnailImage : String


}
//HomeView BookDetail
struct BookDetailInformation : Codable {
    let success : Bool
    let result : BookDetailBookList?
    let errorMessage: String?
}
struct BookDetailBookList : Codable {
    let bookList : BookDetailData?
    let isFavorite : Bool?
}
struct BookDetailData : Codable{
    let TBID : Int
    let SUBTITLE : String?
    let TITLE : String
    let AUTHOR : String
    let ISBN : String
    let PUBLISHER : String
    let PRICE : String
    let PAGE : String
    let BOOK_INDEX : String
    let BOOK_INTRODUCTION : String?
    let PUBLISH_DATE : String
    let Allah_BID : String
    let thumbnailImage :String
    let RATING : Double
    let tagData : [BookDetailDataTagData]
    
}
struct BookDetailDataTagData : Codable {
    let tag : String
    let TMID : Int
}
