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
    let postuserdata : WriteTextDetailPostuserdata
    let commentdata : [WriteTextDetailCommentdata]?
    let commentuserdata : [WriteTextDetailCommentuserdata]?
}
struct WriteTextDetailPostData : Codable {
    let title : String
    let contents : String
    let views : Int
    let createAt : String
    let updateAt : String
    let like : [Int]?
    let UID : Int
}
struct WriteTextDetailPostuserdata : Codable {
    let nickname : String
    let thumbnail : String?
}
struct WriteTextDetailCommentdata : Codable{
    let UID : Int
    let parentID : Int
    let comment : String
    let updateAt : String
    let like : [Int]?
    let CID : Int
    let PID : Int
}
struct WriteTextDetailCommentuserdata : Codable {
    let nickname : String
    let thumbnail : String?
}
