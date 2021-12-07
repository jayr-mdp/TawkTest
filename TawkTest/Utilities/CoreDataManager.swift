//
//  CoreDataManager.swift
//  TawkTest
//
//  Created by JayR- Mac-mini on 12/7/21.
//

import Foundation
import CoreData

class CoreDataManager {

  static let sharedManager = CoreDataManager()
  private init() {}
    
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "TawkTest")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
