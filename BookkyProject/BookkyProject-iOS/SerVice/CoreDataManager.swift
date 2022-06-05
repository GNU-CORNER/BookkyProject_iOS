//
//  CoreDataManager.swift
//  BookkyProject-iOS
//
//  Created by Da Hae Lee on 2022/06/05.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    private lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Searches"
    let maxCount: Int = 10
    
    func save(keyword: String, date: Date) {
        guard let context = self.context else {
            return
        }
        guard let entity = NSEntityDescription.entity(forEntityName: modelName, in: context) else {
            return
        }
        guard let recentKeyword = NSManagedObject(entity: entity, insertInto: context) as? Searches else {
            return
        }
        
        recentKeyword.setValue(keyword, forKey: "keyword")
        recentKeyword.setValue(date, forKey: "date")
        

        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read(ascending: Bool) -> [NSManagedObject] {
        guard let context = self.context else {
            return []
        }
        let sortedByDate = NSSortDescriptor(key: "date", ascending: ascending)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: modelName)
        fetchRequest.sortDescriptors = [sortedByDate]
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func update() {
        
    }
    
    func deleteLastKeyword() {
        guard let context = self.context else {
            return
        }
        
        let searchesList = read(ascending: true)
        if searchesList.count > maxCount {
            for i in 0...(searchesList.count - maxCount) {
                do {
                    context.delete(searchesList[i])
                    try context.save()
                } catch {
                    return
                }
            }
        }
        
    }
    
    
}
