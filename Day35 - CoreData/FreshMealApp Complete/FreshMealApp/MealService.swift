//
//  PersonService.swift
//  MealCollectionDemo
//
//  Created by Kokpheng on 12/5/17.
//  Copyright © 2017 KSHRD. All rights reserved.
//

import UIKit
import CoreData

extension Meal {
    // Insert code here to add functionality to your managed object subclass
    static let entityName = "Meal"
}

class MealService {
    
    // Create object
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // Creates a new Meal
    func create(title: String, shortDescription: String, longDescription: String, thumbnail: Data) -> Meal {
        
        let newMeal = NSEntityDescription.insertNewObject(forEntityName: Meal.entityName, into: context) as! Meal
        newMeal.title = title
        newMeal.short_description = shortDescription
        newMeal.long_description = longDescription
        newMeal.image = thumbnail
        return newMeal
    }
    
    // Gets a meal by id
    func getBy(id: NSManagedObjectID) -> Meal? {
        return context.object(with: id) as? Meal
    }
    
    // Gets all that fulfill the specified predicate.
    // Predicates examples:
    // - NSPredicate(format: "name == %@", "Juan Carlos")
    // - NSPredicate(format: "name contains %@", "Juan")
    func get(withPredicate queryPredicate: NSPredicate) -> [Meal]{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Meal.entityName)
        fetchRequest.predicate = queryPredicate
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Meal]
        } catch let error as NSError {
            // failure
            print(error)
            return [Meal]()
        }
    }
    
    // Gets all.
    func getAll() -> [Meal]{
        return get(withPredicate: NSPredicate(value:true))
    }
    
    // Updates a meal
    func update(updatedPerson: Meal){
        if let meal = getBy(id: updatedPerson.objectID){
            meal.title = updatedPerson.title
            meal.short_description = updatedPerson.short_description
            meal.long_description = updatedPerson.long_description
            meal.image = updatedPerson.image
        }
    }

    // Deletes a meal
    func delete(id: NSManagedObjectID){
        if let mealToDelete = getBy(id: id){
            context.delete(mealToDelete)
        }
    }
    
    // Saves all changes
    func saveChanges(){
        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }
}
