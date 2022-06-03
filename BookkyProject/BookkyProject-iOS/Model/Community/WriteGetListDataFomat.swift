//
//  WriteListDataFomat.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/03.
//

import Foundation
//일반 커뮤니티
struct WriteListInformation : Codable{
    let success : Bool
    let result : TypeResultList
    let errorMessage : String
   
}
struct TypeResultList : Codable{
    let postList : [PostListData]
    let total_size : Int
}
struct PostListData : Codable{
    
    let title : String
    let contents : String
    let commentCnt : Int
    let likeCnt : Int
    let PID : Int

}
// MARK: - 내글 보기
//Data형식 다름
struct PostListMyInformation : Codable {
    let success : Bool
    let result : PostListMyResult
    let errorMessage : String
}
struct PostListMyResult: Codable {
    let postList : [PostLisyMyList]
    let total_size : Int
}
struct PostLisyMyList : Codable {
    let title : String
    let contents : String
    let commentCnt : Int
    let communityType : Int
    let replyCnt : Int
    let PID : Int
    let likeCnt : Int
}
//Hot
struct PostListHotInformation : Codable {
    let success : Bool
    let result : PostListHotResult
    let errorMessage : String
}
struct PostListHotResult : Codable{
    let postList : [PostListHotList]
    let total_size : Int
}
struct PostListHotList : Codable {
    let title : String
    let contents : String
    let commentCnt : Int
    let parentQPID : Int
    let communityType : Int
    let replyCnt : Int
    let PID : Int
    let likeCnt : Int
}
//Q&A DataFormat형식 다름
struct WriteListQnAInformation: Codable {
    let success : Bool
    let result : TypeResultQnAList
    let errorMessage : String
}
struct TypeResultQnAList : Codable{
    let postList : [PostQnAListData]
    let total_size : Int
}
struct PostQnAListData : Codable{
    
    let title : String
    let contents : String
    let commentCnt : Int
    let replyCnt : Int
    let PID : Int
    let likeCnt : Int

}
