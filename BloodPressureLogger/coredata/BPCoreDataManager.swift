//
//  CoreDataManager.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 09/04/22.
//

import CoreData
import UIKit

struct BPCoreDataManager {
    static let shared = BPCoreDataManager()
    
//    let persistentContainer : NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "BPLogs")
//        container.loadPersistentStores(completionHandler: {
//            (storeDesctiption, error) in
//            if let error  = error {
//                fatalError("Loading of store failed \(error)")
//            }
//        })
//        return container
//    }()
    
    func addLog(bp: BP) {
        print("add log")
        // managed context
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        // refensi entity yang telah dibuat sebelumnya
        let entity = NSEntityDescription.entity(forEntityName: "BPLogs", in: managedContext)
        
        // entity body
        var data = NSManagedObject(entity: entity!, insertInto: managedContext) as! BPLogs
        //        var data = BPLogs(context: managedContext)
        mapBPtoBPLog(bpLogs: &data, bp: bp)
        print(data)
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchBPLogs(dateFrom: Date?, dateTo: Date?) -> [BP]? {
        print("fetch logs", dateFrom, dateTo)
        var logs = [BP]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<BPLogs>(entityName: "BPLogs")
        
        let timeSort = NSSortDescriptor(key: "time", ascending: false)
        fetchRequest.sortDescriptors = [timeSort]
        
        var datePredicate : NSPredicate?
        var fromPredicate : NSPredicate?
        var toPredicate : NSPredicate?
        
        if dateFrom != nil && dateTo != nil{
            fromPredicate = NSPredicate(format: "time >= %@", dateFrom! as NSDate)
            toPredicate = NSPredicate(format: "time < %@",  dateTo! as NSDate)
            datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate!, toPredicate!])
            
            fetchRequest.predicate = datePredicate
        }
        
        do {
            let result = try context.fetch(fetchRequest)
            result.forEach{ bpLogs in
                logs.append(
                    mapBPLogtoBP(bpLogs: bpLogs)
                )
            }
            return logs
        } catch let error {
            print("Failed to fetch companies: \(error)")
        }
        
        return nil
    }
    
    func mapBPtoBPLog(bpLogs: inout BPLogs, bp: BP) {
        bpLogs.time = bp.date
        bpLogs.sys = Int64(bp.sysVal)
        bpLogs.dia = Int64(bp.diaVal)
        bpLogs.pulse = Int64(bp.pulse)
        bpLogs.createdDate = NSDate() as Date
    }
    
    func mapBPLogtoBP(bpLogs: BPLogs) -> BP {
        let bp = BP(date: bpLogs.time!, sysVal: Int(bpLogs.sys), diaVal: Int(bpLogs.dia), pulse: Int(bpLogs.pulse))
        return bp
    }
}
//
//struct CoreDataManager{
//    static let shared = CoreDataManager()
//
//    let persistentContainer : NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "User")
//        container.loadPersistentStores(completionHandler: {
//            (storeDesctiption, error) in
//            if let error  = error {
//                fatalError("Loading of store failed \(error)")
//            }
//        })
//        return container
//    }()
//
//    func createEmployee(name: String) -> User? {
//            let context = persistentContainer.viewContext
//
//            let employee = User(context: context)
//
//            employee.name = name
//
//            do {
//                try context.save()
//                return employee
//            } catch let error {
//                print("Failed to create: \(error)")
//            }
//
//            return nil
//        }
//}
