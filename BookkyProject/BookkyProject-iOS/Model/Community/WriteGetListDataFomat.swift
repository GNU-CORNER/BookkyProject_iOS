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
//    let userData : [CommunityUserData]
    let subData : [CommunitySubData]
}
struct PostListData : Codable{
    let PID : Int
    let title : String
    let contents : String
//    let like : [Int]
}
struct CommunityUserData : Codable{
    let nickname : String
    let thumbnail : String?
}
struct CommunitySubData : Codable{
    let commentCnt :Int
    let likeCnt : Int
}
