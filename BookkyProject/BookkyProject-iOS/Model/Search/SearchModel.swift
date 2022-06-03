//
//  SearchMode.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/18.
//

import Foundation
struct SearchModel {
    static var didSearch: Bool = false

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
