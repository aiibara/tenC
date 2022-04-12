//
//  ActivityCoreDataManager.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 11/04/22.
//

import CoreData
import UIKit

struct ActivityCoreDataManager {
    static let shared = ActivityCoreDataManager()
    
    func addActivity(act: Act) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Activity", in: managedContext)
        var data = NSManagedObject(entity: entity!, insertInto: managedContext) as! Activity
        
        mapActtoActivity(activity: &data, act: act)
        print(data)
        
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchActivities(dateFrom: Date?, dateTo: Date?) -> [Act]? {
        print("fetch activities", dateFrom, dateTo)
        var acts = [Act]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        
        let timeSort = NSSortDescriptor(key: "start", ascending: true)
        fetchRequest.sortDescriptors = [timeSort]
        
        var datePredicate : NSPredicate?
        var fromPredicate : NSPredicate?
        var toPredicate : NSPredicate?
        
        if dateFrom != nil && dateTo != nil{
            fromPredicate = NSPredicate(format: "activityDate >= %@", dateFrom! as NSDate)
            toPredicate = NSPredicate(format: "activityDate < %@",  dateTo! as NSDate)
            datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate!, toPredicate!])
            fetchRequest.predicate = datePredicate
        }
        
        do {
            let result = try context.fetch(fetchRequest)
            result.forEach{ activity in
                acts.append(
                    mapActivitytoAct(activity: activity)
                )
            }
            
            print(acts)
            return acts
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    func updateActivity(act: Act) {
        print("update Activity", act)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.fetchLimit = 1
        
        let idPredicate = NSPredicate(format: "id == %@", act.id! as CVarArg)
        fetchRequest.predicate = idPredicate
        
        do {
            let result = try context.fetch(fetchRequest)
            for activity in result {
                if activity.id == act.id {
                    activity.start = act.start
                    activity.end = act.end
                    activity.desc = act.desc
                    activity.activityDate = act.activityDate
                    break
                }
            }
            try context.save()
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
    }
    
    func deleteActivity(id: UUID) {
        print("delete Activity", id)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<Activity>(entityName: "Activity")
        fetchRequest.fetchLimit = 1
        
        let idPredicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.predicate = idPredicate
        
        do {
            let result = try context.fetch(fetchRequest)
            for activity in result {
                if activity.id == id {
                    context.delete(activity)
                }
            }
            try context.save()
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
    }
    
    func mapActtoActivity(activity: inout Activity, act: Act) {
        activity.start = act.start
        activity.end = act.end
        activity.desc = act.desc
        activity.activityDate = act.activityDate
        activity.createdDate = act.createdDate
        activity.id = act.id
    }
    
    func mapActivitytoAct(activity: Activity) -> Act {
        let act = Act(id: activity.id, desc: activity.desc, end: activity.end, start: activity.start, createdDate: activity.createdDate, activityDate: activity.activityDate)
        return act
    }
    
}
