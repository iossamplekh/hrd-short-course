//
//  MealService.swift
//  FreshMealApp
//
//  Created by KSHRD on 12/7/17.
//  Copyright © 2017 Kokpheng. All rights reserved.
//

import UIKit
import CoreData

extension Meal {
    
    //Entity Name
    static let entityName = "Meal"
}


class MealService{
    //s 3
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    func create(title:String,shortDesription:String,logDescription:String,thumImage: Data)->Meal{
        let newMeal = NSEntityDescription.insertNewObject(forEntityName: Meal.entityName, into: context) as! Meal
        
        newMeal.title = title
        newMeal.short_description = shortDesription
        newMeal.long_description = logDescription
        newMeal.image = thumImage
        
        return newMeal
    }
    // 6
    func getBy(id: NSManagedObjectID)-> Meal?{
        return context.object(with: id) as? Meal
    }
    // 7 filler
    //withPredicate: -> rename parameter
    //No sql
    // Predicates example:
    // - NSPredicate(format: "name == %","Juan Carlos")
    // - NSPredicate(format: "name == contains %@","Juan Carlos")
    //Get
    func get(withPredicate queryPredicate: NSPredicate) -> [Meal] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:Meal.entityName)
        //Appy codition
        fetchRequest.predicate = queryPredicate
        
        do{
            let response = try context.fetch(fetchRequest)
            return response as! [Meal]
        }catch let error as NSError{
            print(error)
            return [Meal]()// return empty record
        }
    }
    // Get all
    func getAll()->[Meal]{
        return get(withPredicate: NSPredicate(value: true))
    }
    // Update
    func update(updateMeal: Meal){
        if let meal = getBy(id: updateMeal.objectID){
            meal.title = updateMeal.title
            meal.short_description = updateMeal.short_description
            meal.long_description = updateMeal.long_description
            meal.image = updateMeal.image
        }
    }
    // Delete
    func delete(id:NSManagedObjectID){
        if let mealToDelete = getBy(id: id){
            context.delete(mealToDelete)
        }
    }
    // Save
    func saveChange(){
        do{
            try context.save()
        }catch let error as NSError{
            print(error)
        }
    }
}

