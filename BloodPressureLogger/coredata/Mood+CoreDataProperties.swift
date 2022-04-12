//
//  Mood+CoreDataProperties.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 10/04/22.
//
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood")
    }

    @NSManaged public var type: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var notes: String?

}

extension Mood : Identifiable {
    
}
