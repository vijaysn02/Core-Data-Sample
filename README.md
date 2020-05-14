# Core Data Sample

## Introduction:

This project is created to understand the working of Core Data and also to have a ready made component for integration in the projects. 

If you want to implement it straight away, you can make copy the handler in the project and jump to the Usage part.

---------------------------------------------------------------------------------------------------

## Installation:


There is no specific installation needed for this implementation.


----------------------------------------------------------------------------------------------------

## Configuration:

You need to enable Use Core Data option while creating your project.

----------------------------------------------------------------------------------------------------

## Coding Part - Handler:

There are two important section of this handler. (i) Reading and Writing

### Reading 

```
    static func readGroceries() {
        
        // 1 - Creating Shared instance of App Delegate
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 2 - Creating Context for Peristant Container
        let context =
          appDelegate.persistentContainer.viewContext
        
        //3 - Fetch Request for the Entity
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Grocery")
        
        //4 - Read Groceries from Entity
        do {
          groceries = try context.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
```

### Writing

```
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
```


----------------------------------------------------------------------------------------------------

## Helper Part

### Toast is used for assisting the main functionality

----------------------------------------------------------------------------------------------------

## Usage Part

### Invoke the below specific function for saving your data. 


```
    DatabaseHandler.saveGrocery(name: grocery)
```

### Invoke the below specific function for retrieving your data. 


```
    DatabaseHandler.readGroceries()
```


### Check out my Post about Core Data : [iOS - Core Data Sample](https://vijaysn.com/mobile/ios/ios-core-data-i)
