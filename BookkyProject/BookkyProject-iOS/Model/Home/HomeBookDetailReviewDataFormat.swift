//
//  HomeBookDetailReviewDataFormat.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/10.
//

import Foundation

//HomeView BookDetail Review
struct BookDetailReviewInformation : Codable {
    let success : Bool
    let result : ReviewDataList
    let errorMessage: String
}
struct ReviewDataList : Codable {
    let reviewList : [ReviewData]
}
struct ReviewData : Codable {
    let RID : Int
    let TBID : Int
    let UID : Int
    let contents : String
    let views : Int
    let createAt : String
    let rating : Double
    let likeCnt : Int
    let isLiked : Bool
    let isAccessible : Bool
    let nickname : String

}
