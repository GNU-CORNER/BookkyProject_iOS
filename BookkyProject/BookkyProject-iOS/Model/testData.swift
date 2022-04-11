////
////  testData.swift
////  BookkyProject-iOS
////
////  Created by 원동진 on 2022/04/08.
////
//
//import Foundation
//struct Book {
//    var bookName : String
//    var bookImage :String
//}
//struct tagBook{
//    var tagname : String
//    var book : [Book]
//}
//
//struct BookData {
//    var object = [tagBook(tagname: "파이썬", book: [Book(bookName: "파이썬책1", bookImage: "bookImage"),
//                                                 Book(bookName: "파이썬책2", bookImage: "bookImage"),
//                                                 Book(bookName: "파이썬책3", bookImage: "bookImage"),
//                                                 Book(bookName: "파이썬책4", bookImage: "bookImage"),
//                                                 Book(bookName: "파이썬책5", bookImage: "bookImage")
//                                                ])
//                  ,
//                  tagBook(tagname: "html", book: [Book(bookName: "html1", bookImage: "bookImage"),
//                                                  Book(bookName: "html책2", bookImage: "bookImage"),
//                                                  Book(bookName: "html책3", bookImage: "bookImage"),
//                                                  Book(bookName: "html책4", bookImage: "bookImage"),
//                                                  Book(bookName: "html책5", bookImage: "bookImage")
//                                                 ])
//                  ,
//                  tagBook(tagname: "css", book: [Book(bookName: "css책1", bookImage: "bookImage"),
//                                                  Book(bookName: "css책2", bookImage: "bookImage"),
//                                                  Book(bookName: "css책3", bookImage: "bookImage"),
//                                                  Book(bookName: "css책4", bookImage: "bookImage"),
//                                                  Book(bookName: "css책5", bookImage: "bookImage")
//                                                 ])
////                  , tagBook(tagname: "css", book: [Book(bookName: "css책1", bookImage: "bookImage"),
////                                                   Book(bookName: "css책2", bookImage: "bookImage"),
////                                                   Book(bookName: "css책3", bookImage: "bookImage"),
////                                                   Book(bookName: "css책4", bookImage: "bookImage"),
////                                                   Book(bookName: "css책5", bookImage: "bookImage")
////                                                  ])
//    ]
//    
//}
//
//  testData.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/06.
//

import Foundation
struct BoardText{
    let title : String
    let subtitle : String
}
struct Free {
    var objectArray = [BoardText(title: "자유게시판입니다.", subtitle: "자유롭게 글을 작성해주세요. 에티켓은 꼭 지켜주시구요 !! 반가워요 모두들~행복한 2022년 보내세요 개서적 많이 많이 써주세요."),
                       BoardText(title: "자유게시판입니다.", subtitle: "자유롭게 글을 작성해주세요. 에티켓은 꼭 지켜주시구요 !! 반가워요 모두들~행복한 2022년 보내세요 개서적 많이 많이 써주세요."),
                       BoardText(title: "자유게시판입니다.", subtitle: "자유롭게 글을 작성해주세요. 에티켓은 꼭 지켜주시구요 !! 반가워요 모두들~행복한 2022년 보내세요 개서적 많이 많이 써주세요."),
                       BoardText(title: "자유게시판입니다.", subtitle: "자유롭게 글을 작성해주세요. 에티켓은 꼭 지켜주시구요 !! 반가워요 모두들~행복한 2022년 보내세요 개서적 많이 많이 써주세요."),
                       BoardText(title: "자유게시판입니다.", subtitle: "자유롭게 글을 작성해주세요. 에티켓은 꼭 지켜주시구요 !! 반가워요 모두들~행복한 2022년 보내세요 개서적 많이 많이 써주세요.")
    ]
}
struct Hot {
    var objectArray = [BoardText(title: "hot", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url                    session 질문 컬렉션뷰 질문"),
                       BoardText(title: "hot", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "hot", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "hot", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "hot", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문")
    ]
}
struct QnA {
    var objectArray = [BoardText(title: "질문이 있습니다.", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url                    session 질문 컬렉션뷰 질문"),
                       BoardText(title: "질문이 있습니다.", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "질문이 있습니다.", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "질문이 있습니다.", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "질문이 있습니다.", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문")
    ]
}

struct BookMarket{
    var objectArray = [BoardText(title: "이 책 사세요", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url                    session 질문 컬렉션뷰 질문"),
                       BoardText(title: "이 책 사세요", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "이 책 사세요", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "이 책 사세요", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "이 책 사세요", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문")
    ]
}
struct Mytext{
    var objectArray = [BoardText(title: "내글", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url                    session 질문 컬렉션뷰 질문"),
                       BoardText(title: "내글", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "내글", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "내 글", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문"),
                       BoardText(title: "내 글", subtitle: "여러분 이문제 도대체 어떻게 푸나요 . 아무리해 도 감이 안오네요 답좀 알려주세요 제발요 .. 부탁입니다 . 테이블뷰 질문 url session 질문 컬렉션뷰 질문")
    ]
}
