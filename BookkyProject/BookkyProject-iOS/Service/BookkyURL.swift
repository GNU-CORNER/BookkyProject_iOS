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
    //signup
    static let signupURL = "/user/signup"
    static let signinURL = "/user/signin"
    static let refreshURL = "/auth/refresh"
    //MyProfile
    static let myprofilePath = "/myprofile"
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
    //Community
    static let communityPostListGetURL =  "/community/postlist/"
    static let communityWritePostURL = "/community/writepost/"
    static let communityTextDetail = "/community/postdetail/"
    
    static let nicknameCheckPath = "/user/nickname"
    
    static let tagsPath = "/tags"
}
