//
//  Searches+CoreDataProperties.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/05.
//
//

import Foundation
import CoreData


extension Searches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Searches> {
        return NSFetchRequest<Searches>(entityName: "Searches")
    }

    @NSManaged public var keyword: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?

}

extension Searches : Identifiable {

}
