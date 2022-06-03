//
//  BookkyURL.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/04/06.
//

import Foundation

class BookkyURL {
    // baseURL
    static let baseURL = "http://203.255.3.144:8002/v1"
    //sig
    static let signupURL = "/user/signup"
    static let signinURL = "/user/signin"
    static let refreshURL = "/auth/refresh"
    static let signoutPath = "/user/signout"
    static let userPath = "/user"
    //MyProfile
    static let myprofilePath = "/myprofile"
// MARK: - 홈 Get

    static let myprofileUpdatePath = "/user/myprofile"
    static let favoriteBookPath = "/user/favoritebook/"
    static let myPostsPath = "/user/mypost"
    static let myReviewsPath = "/user/myreview"
    static let userTagsPath = "/user/tag"
    //Home
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
    static let communityLikePost = "/community/like/"   //좋아요
// MARK: - 커뮤니티 Delete
    static let communityDeletePostURL = "/community/deletepost/"
    static let communityDeleteCommentURL = "/community/deletecomment/"
    static let nicknameCheckPath = "/user/nickname"
    static let tagsPath = "/tags"
// MARK: - 커뮤니티 Search
static let communitySearchPostURL = "/community/search?keyword="
static let communitySearchBookURL = "/community/post/book?keyword="
}
