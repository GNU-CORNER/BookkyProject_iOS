//
//  SearchMode.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/18.
//

import Foundation

// MARK: - SearchModel
struct SearchModel: Codable {
    static var didSearch: Bool = false
    let success: Bool
    let result: SearchResult?
    let errorMessage: String
}

// MARK: - Result
struct SearchResult: Codable {
    let searchData: [SearchDatum]
    let total: Int
}

// MARK: - SearchDatum
struct SearchDatum: Codable {
    let tbid: Int
    let title, author: String
    let thumbnailImage: String
    let rating: Double
    let bookIntroduction, publishDate, publisher: String
    let tagData: [TagDatum]

    enum CodingKeys: String, CodingKey {
        case tbid = "TBID"
        case title = "TITLE"
        case author = "AUTHOR"
        case thumbnailImage
        case rating = "RATING"
        case bookIntroduction = "BOOK_INTRODUCTION"
        case publishDate = "PUBLISH_DATE"
        case publisher = "PUBLISHER"
        case tagData
    }
}

// MARK: - TagDatum
struct TagDatum: Codable {
    let tag: String
    let tmid: Int

    enum CodingKeys: String, CodingKey {
        case tag
        case tmid = "TMID"
    }

}
// MARK: - 커뮤니티글 검색
struct PostSearchModel : Codable{
    let success : Bool
    let result : [PostSearchData]
    let errorMessage : String
}
struct PostSearchData : Codable {
    let title : String
    let contents : String
    let PID : Int
    let communityType : Int
    let likeCnt : Int
    let commentCnt : Int
    let replyCnt : Int
 
}
// MARK: - 커뮤니티 글작성 책검색
struct BookSearchInformation : Codable{
    let success : Bool
    let result : BookSearchData
    let errorMessage : String
}
struct BookSearchData : Codable{
    let searchData : [BookSearchDataList]
    let total : Int
}
struct BookSearchDataList : Codable{
    let TBID : Int
    let TITLE : String
    let AUTHOR : String
    let thumbnailImage : String
    let PUBLISHER : String
}
