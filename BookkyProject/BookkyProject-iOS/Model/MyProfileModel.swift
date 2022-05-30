//
//  BookkyModel.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/05/10.
//

import Foundation

// MARK: - MyprofileModel
struct MyprofileModel: Codable {
    let success: Bool
    let result: MyprofileResult?
    let errorMessage: String?
}

// MARK: - Result
struct MyprofileResult: Codable {
    let userData: MyprofileUserData?
    let favoriteBookList: [FavoriteBookList]?
    let userPostList: [UserPostList]?
    let userReviewList: [UserReviewList]?
    /// myprofile detail
    let communityList: [UserPostList]?
    let reviewList: [UserReviewList]?
}

// MARK: - UserData
struct MyprofileUserData: Codable {
    let userThumbnail: String?
    let nickname: String
    let userTagList: [UserTagList]
}

// MARK: - FavoriteBookList
struct FavoriteBookList: Codable {
    let tbid: Int
    let title: String
    let author: String?
    let thumbnailImage: String
    let rating: Double?

    enum CodingKeys: String, CodingKey {
        case tbid = "TBID"
        case title = "TITLE"
        case author = "AUTHOR"
        case thumbnailImage
        case rating = "RATING"
    }
}

// MARK: - UserTagList
struct UserTagList: Codable {
    let tag: String
    let tmid: Int

    enum CodingKeys: String, CodingKey {
        case tag
        case tmid  = "TMID"
    }
}

// MARK: - UserPostList
struct UserPostList: Codable {
    let title, contents: String
    let communityType, pid, commentCnt, likeCnt: Int

    enum CodingKeys: String, CodingKey {
        case title, contents, communityType
        case pid = "PID"
        case commentCnt, likeCnt
    }
}

// MARK: - UserReviewList
struct UserReviewList: Codable {
    let rid, tbid, uid: Int
    let contents: String
    let views: Int
    let createAt: String
    let rating: Double
    let likeCnt: Int
    let isLiked, isAccessible: Bool
    let nickname, author, bookTitle: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case rid = "RID"
        case tbid = "TBID"
        case uid = "UID"
        case contents, views, createAt, rating, likeCnt, isLiked, isAccessible, nickname
        case author = "AUTHOR"
        case bookTitle, thumbnail
    }
}
