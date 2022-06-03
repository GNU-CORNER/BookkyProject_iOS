//
//  BookkyURL.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/06.
//

import Foundation

class BookkyURL {
    static let baseURL = "http://203.255.3.144:8002/v1"
    static let signupURL = "/user/signup"
    static let signinURL = "/user/signin"
    static let refreshURL = "/auth/refresh"
    
    static let myprofilePath = "/myprofile"
// MARK: - 홈 Get
    static let HomeURL = "/home"
    static let tagURL = "/books/tag/"
    static let tagMoreViewURL = "/home/tags"
    static let bookDetatilURL = "/books/detail/"
    static let bookDetailReview = "/books/reviews/"
// MARK: - 커뮤니티 Get
    static let communityPostListGetURL =  "/community/postlist/"
    static let communityTextDetail = "/community/postdetail/"
    static let communityQnACommentGetURL = "/community/comment/"
    static let communityHotPostListGetURL = "/community/hotcommunity"
// MARK: - 커뮤니티 post
    static let communityWritePostURL = "/community/writepost/"
    static let communityCommetPostURL = "/community/writecomment/"
// MARK: - 커뮤니티 Delete
    static let communityDeletePostURL = "/community/deletepost/"
    static let communityDeleteCommentURL = "/community/deletecomment/"
// MARK: - 커뮤니티 Search
    static let communitySearchPostURL = "/community/search?keyword="
}
