//
//  ViewController.swift
//  MealCollectionDemo
//
//  Created by KSHRD on 11/23/17.
//  Copyright © 2017 KSHRD. All rights reserved.
//

import UIKit

class FreshMealHomeTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // Outlet
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    // Property
    var mealData : [Meal] = []
    var displayedData : [Meal] = []
    var filteredData:[Meal] = []
    var mealService = MealService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Fresh Meal Menu"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupTableView()
        
        setupSearchController() 
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        
        // Get all data
        mealData = mealService.getAll()
        displayedData = mealData
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
    }
    
    func setupSearchController() {
        resultSearchController.searchBar.placeholder = "Search here"
        navigationItem.hidesSearchBarWhenScrolling = true
        resultSearchController.hidesNavigationBarDuringPresentation = true
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.default
        resultSearchController.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        resultSearchController.searchBar.sizeToFit()
        resultSearchController.searchResultsUpdater = self
      
        if #available(iOS 11.0, *) {
            navigationItem.searchController = resultSearchController
        } else {
            tableView.tableHeaderView = resultSearchController.searchBar
        }
    }
    
    
    // MARK : Search Controller
    func updateSearchResults(for searchController: UISearchController) {
        // Check if the user cancelled or deleted the search term so we can display the full list instead.
        
        if (searchController.searchBar.text?.count)! > 0 {
            // 1 Remove all data
            filteredData.removeAll(keepingCapacity: false)
            // 2 Create Predication
            let searchPredicate = NSPredicate(format: "SELF.title CONTAINS[c] %@", searchController.searchBar.text!)
            
            // 3 Create an instance of the service.
            let mealService = MealService()
            
            // 4 filter data by predication
            filteredData = mealService.get(withPredicate: searchPredicate)
            
            // 5 display data
            self.displayedData = self.filteredData
        }else{
            self.displayedData = self.mealData
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check segue id
        if segue.identifier == "showMealDetail" {
            // Get MealDetailViewController object from Segue Destination
            let dest = segue.destination as! MealDetailViewController
            dest.mealHolder = sender as! Meal  // Pass Data
            
        }else if segue.identifier == "showEdit" {
            let destViewController = segue.destination as! AddEditMealTableViewController
            destViewController.meal = sender as! Meal  // Pass Data
        }
    }
}

extension FreshMealHomeTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell") as! MealTableViewCell
        cell.configureCell(with: displayedData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultSearchController.isActive = false
        
        // Get Data from each selected row
        let meal = displayedData[indexPath.row]
        // Call Segue with ID
        performSegue(withIdentifier: "showMealDetail", sender: meal)
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, index) in
            // find delete object by id
            let deletedMeal = self.mealService.getBy(id: self.displayedData[indexPath.row].objectID)
            
            // delete
            self.mealService.delete(id: (deletedMeal?.objectID)!)
            self.displayedData.remove(at: indexPath.row)
            self.mealService.saveChanges()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, index) in
            self.performSegue(withIdentifier: "showEdit", sender: self.displayedData[indexPath.row])
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9587053657, green: 0.3523139656, blue: 0.01222745888, alpha: 1)
        
        return [delete, edit]
    }
}

