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
struct WriteTextDetailData : Codable{
    let postdata : WriteTextDetailPostData
    let commentdata : [WriteTextDetailCommentdata]?
    let commentCnt : Int?
}
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
struct WriteTextDetailCommentdata : Codable{
    let comment : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
    let childComment : [ChildComment]?
}
struct ChildComment : Codable{
    let comment : String
    let updateAt : String
    let like : [Int]?
    let nickname : String
    let thumbnail : String?
}
