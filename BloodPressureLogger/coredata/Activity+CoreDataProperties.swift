//
//  Activity+CoreDataProperties.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 11/04/22.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var end: Date?
    @NSManaged public var start: Date?
    @NSManaged public var createdDate: Date?
    @NSManaged public var activityDate: Date?
    @NSManaged public var id: UUID?
}

extension Activity : Identifiable {

}
