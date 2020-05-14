//
//  ViewController.swift
//  Sportrush Ambulance
//
//  Created by TPFLAP146 on 22/02/20.
//  Copyright © 2020 spotrush. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHandler {
    
    static var groceries: [NSManagedObject] = []
    
    static func saveGrocery(name: String) {
      
      // 1 - Creating Shared instance of App Delegate
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 2 - Creating Context for Peristant Container
      let containerContext = appDelegate.persistentContainer.viewContext
      
      
      // 3 - Entity - Reference
      let entity =
        NSEntityDescription.entity(forEntityName: "Grocery",
                                   in: containerContext)!
      
      // 4 - Entity - Object Creation
      let grocery = NSManagedObject(entity: entity,
                                   insertInto: containerContext)
      
      // 5 - Seting Attributes of an entity
      grocery.setValue(name, forKeyPath: "name")
      
      // 6 - Saving the Entity
      do {
        try containerContext.save()
        groceries.append(grocery)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
        
    }
    
    static func readGroceries() {
        
        // 1 - Creating Shared instance of App Delegate
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 2 - Creating Context for Peristant Container
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        //3 - Fetch Request for the Entity
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Grocery")
        
        //4 - Read Groceries from Entity
        do {
          groceries = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
}


