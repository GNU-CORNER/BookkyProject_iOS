//
//  WriteTextDetailDataFormat.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/09.
//

import Foundation

struct WriteTextDetailInformation : Codable {
    let success : Bool
    let result : WriteTextDetailData
    let errorMessage :String
}
//1차원배열
struct WriteTextDetailData : Codable{
    let postdata : WriteTextDetailPostData
    let commentdata : [WriteTextDetailCommentdata]?
    let commentCnt : Int?
}
//2차원배열
//struct WriteTextDetailData : Codable{
//    let postdata : WriteTextDetailPostData
//    let commentdata : [WriteTextDetailCommentdata]?
//    let commentCnt : Int?
//}

struct WriteTextDetailPostData : Codable {
    let title : String
    let contents : String
    let views : Int
    let createAt : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
}
//1차원배열
struct WriteTextDetailCommentdata : Codable{
    let comment : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
    let isAccessible : Bool
    let CID : Int
    let reply : Int
}
//2차원배열
//struct WriteTextDetailCommentdata : Codable{
//    let comment : String
//    let updateAt : String
//    let like : [Int]?
//    let nickname : String
//    let thumbnail : String?
//    let childComment : [ChildComment]?
//}
//struct ChildComment : Codable{
//    let comment : String
//    let updateAt : String
//    let like : [Int]?
//    let nickname : String
//    let thumbnail : String?
//}
//Q&A Detail
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
