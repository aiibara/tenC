//
//  BPLogs+CoreDataProperties.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 10/04/22.
//
//

import Foundation
import CoreData


extension BPLogs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BPLogs> {
        return NSFetchRequest<BPLogs>(entityName: "BPLogs")
    }

    @NSManaged public var time: Date?
    @NSManaged public var sys: Int64
    @NSManaged public var dia: Int64
    @NSManaged public var pulse: Int64
    @NSManaged public var createdDate: Date?

}

extension BPLogs : Identifiable {

}
