//
//  WriteTextDetailDataFormat.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/09.
//

import Foundation
//1차원배열
//struct WriteTextDetailCommentdata : Codable{
//    let comment : String
//    let updateAt : String
//    let like : [Int]?
//    let nickname : String
//    let thumbnail : String?
//    let isAccessible : Bool
//    let CID : Int
//    let reply : Int
//}
//1차원배열
//struct WriteTextDetailData : Codable{
//    let postdata : WriteTextDetailPostData
//    let commentdata : [WriteTextDetailCommentdata]?
//    let commentCnt : Int?
//}
struct WriteTextDetailInformation : Codable {
    let success : Bool
    let result : WriteTextDetailData
    let errorMessage :String
}

struct WriteTextDetailData : Codable{
    let postdata : WriteTextDetailPostData
    let commentdata : [WriteTextDetailCommentdata]?
    let commentCnt : Int?
    let Book : PostDetailBookData?
}

struct WriteTextDetailPostData : Codable {
    let title : String
    let contents : String
    let views : Int
    let createAt : String
    let updateAt : String
    let like : [Int]?
    let postImage : [String]?
    let nickname : String
    let thumbnail : String?
    let isAccessible : Bool
}

//2차원배열
struct WriteTextDetailCommentdata : Codable{
//    let parentID : Int
    let comment : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
    let childComment : [ChildComment]?
    let CID : Int
    let isAccessible : Bool
}
struct PostDetailBookData : Codable {
    let TBID : Int?
    let TITLE : String?
    let AUTHOR : String?
    let thumbnailImage : String?
    let RATING : Double?
    let PUBLISHER : String?
}
//2차원배열
struct ChildComment : Codable{
//    let parentID : Int
    let comment : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
    let CID: Int
    let isAccessible : Bool
}
// MARK: - Q&A Detail
struct WriteTextDetailQnAInformation :Codable {
    let success : Bool
    let result : WriteQnATextDetailData
    let errorMessage :String
}
struct WriteQnATextDetailData : Codable {
    let postdata : WriteTextDetailQnAPostData
    let replydata : [WriteTextDetailQnAReplyData]?
    let commentCnt : Int?
    let replyCnt : Int
}

struct WriteTextDetailQnAPostData : Codable {
    let title : String
    let contents : String
    let views : Int
    let createAt : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
    let isAccessible : Bool
    let TBID : Int
}
struct WriteTextDetailQnAReplyData : Codable{
    let title : String
    let contents : String
    let views : Int
    let createAt : String
    let updateAt : String
    let like : [Int]?
    let parentQPID : Int
    let nickname : String
    let thumbnail : String?
    let PID : Int
    let commentCnt : Int?
    let isAccessible : Bool
    let TBID : Int
}
// MARK: -Q&A 댓글 데이터 format
struct QnACommentDataInformation : Codable {
    let success : Bool
    let result : QnACommentResult
    let errorMessage :String
}
struct QnACommentResult : Codable {
    let commentdata : [QnACommentDataList]
    let commentCnt : Int
}
struct QnACommentDataList : Codable {
    let comment : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
    let isAccessible: Bool
    let CID : Int
    let childComment : [QnAChildComment]?
}
struct QnAChildComment :Codable {
    let comment : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
    let isAccessible : Bool
    let CID : Int
}
