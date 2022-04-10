//
//  testData.swift
//  BookkyProject-iOS
//
//  Created by 원동진 on 2022/04/08.
//

import Foundation
struct Book {
    var bookName : String
    var bookImage :String
}
struct tagBook{
    var tagname : String
    var book : [Book]
}

//struct BookData {
//    var object = [tagBook(tagname: "파이썬", book: [Book(bookName: "책1", bookImage: "bookImage"),
//                                                 Book(bookName: "책1", bookImage: "bookImage"),
//                                                 Book(bookName: "책1", bookImage: "bookImage"),
//                                                 Book(bookName: "책1", bookImage: "bookImage"),
//                                                 Book(bookName: "책1", bookImage: "bookImage")
//                                                ])
//                  ,
//                  tagBook(tagname: "html", book: [Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage")
//                                                 ])
//                  ,
//                  tagBook(tagname: "html", book: [Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage"),
//                                                  Book(bookName: "책1", bookImage: "bookImage")
//                                                 ])
//    ]
//    
//}
