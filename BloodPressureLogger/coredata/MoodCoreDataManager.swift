//
//  MoodCoreDataManager.swift
//  BloodPressureLogger
//
//  Created by Widya Limarto on 10/04/22.
//

import CoreData
import UIKit

struct MoodCoreDataManager {
    static let shared = MoodCoreDataManager()
    
    func addMood(emo: Emo) {
        print("add log")
        // managed context
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        // refensi entity yang telah dibuat sebelumnya
        let entity = NSEntityDescription.entity(forEntityName: "Mood", in: managedContext)
        
        // entity body
        var data = NSManagedObject(entity: entity!, insertInto: managedContext) as! Mood
        
        mapEmotoMood(mood: &data, emo: emo)
        print(data)
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchMoods() -> [Emo]? {
        print("fetch moods")
        var moods = [Emo]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<Mood>(entityName: "Mood")
        
        let timeSort = NSSortDescriptor(key: "createdDate", ascending: true)

        fetchRequest.sortDescriptors = [timeSort]
        
        do {
            let result = try context.fetch(fetchRequest)
            result.forEach{ mood in
                moods.append(
                    mapMoodtoEmo(mood: mood)
                )
            }
            return moods
        } catch let error {
            print("Failed to fetch moods: \(error)")
        }
        
        return nil
    }
    
    func mapEmotoMood(mood: inout Mood, emo: Emo) {
        mood.createdDate = emo.createdDate
        mood.type = emo.type
        mood.notes = emo.notes
    }
    
    func mapMoodtoEmo(mood: Mood) -> Emo {
        let emo = Emo(type: mood.type!, createdDate: mood.createdDate!, notes: mood.notes!)
        return emo
    }
}
