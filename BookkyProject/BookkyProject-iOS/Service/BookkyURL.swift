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
    
    //Home
    static let HomeURL = "/home"
    static let tagURL = "/books/tag/"
    static let bookDetatilURL = "/books/detail/"
    //Community
    static let communityPostListGetURL =  "/community/postlist/"
    static let communityWritePostURL = "/community/writepost/"
    static let communityTextDetail = "/community/postdetail/"
    
}
