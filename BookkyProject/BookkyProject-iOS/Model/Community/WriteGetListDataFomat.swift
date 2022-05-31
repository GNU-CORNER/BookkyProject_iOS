//
//  WriteListDataFomat.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/05/03.
//

import Foundation

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
    let likeCnt : Int
    let replyCnt : Int
    let PID : Int

}
