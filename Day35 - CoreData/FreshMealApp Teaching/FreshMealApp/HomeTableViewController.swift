//
//  HomeTableViewController.swift
//  FreshMealApp
//
//  Created by KSHRD on 12/6/17.
//  Copyright © 2017 Kokpheng. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController ,UISearchResultsUpdating{
    
    // Outlet
    var resultSearchController = UISearchController(searchResultsController: nil)
    let a = [
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/59f25b63a1e1ea6b9e0b9c92-cca4af7f.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/59f25c0dc9fd0832717e2482-ad6134a4.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/upgraded-steak-and-potatoes-d9c26f65.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/pancetta-flatbread-pizzas-5b58cf2e.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/cheddar-smash-burgers-34f4bb93.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/5a036e0651d3f13c8a55a472-d4793e56.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/mediterranean-chicken-thigh-d1bf9150.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/kale-grilled-cheese-sandwich-ebe54e0c.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/spiced-cauliflower-mac-n-cheese-7bc85539.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/chipotle-seitan-chili-1aca3f82.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/brown-rice-bibimbap-57d34f4e.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/cheddar-smash-burgers-998331d8.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/59f25e30a2882a217d17ffc2-dce29963.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/59f25f08a2882a23b21b5112-2eea7a90.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/5a04abf5a2882a5e7f3e0fe2-0af52f06.jpg",
        "https://d3hvwccx09j84u.cloudfront.net/640,0/image/sizzling-balsamic-steak-04907d3a.jpg"]

    

    var data: [Meal] = []
    var mealService = MealService()
    var displayedData : [Meal] = []
    var filteredData:[Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "Fresh Meal"
        // Display LargeTitles
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode = .automatic
        }
        setupTableView()
       
        setupSearchController()

    }


    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        data = mealService.getAll()
        displayedData = data
        tableView.reloadData()
        print("\(data)")
    }
 
    func setupTableView(){
        // dynamic row
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Register Custom Cell
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
    }
//
    func setupSearchController() {
        resultSearchController.searchBar.placeholder = "Search here"
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            // Fallback on earlier versions
        }
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

//
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
            self.displayedData = self.data
        }
        tableView.reloadData()

    }
//

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEdit" {
            print("==========ShowEdit =========")
            let dest = segue.destination as! AddEditMealTableViewController
            dest.mealHolder = sender as? Meal
        }
        if segue.identifier == "MealDetailViewController" {
            // Get MealDetailViewController object from Segue Destination
            let dest = segue.destination as! MealDetailViewController
            dest.mealHolder = sender as! Meal  // Pass Data
        }
        else{
            print("==========Unknown =======")
        }

    }
   

}

extension HomeTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        cell.configurCell(with: data[indexPath.row])
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get Data from each selected row
        let meal = displayedData[indexPath.row]
        // Call Segue with ID
        performSegue(withIdentifier: "MealDetailViewController", sender: meal)
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            
            let deleteMeal = self.mealService.getBy(id: self.data[indexPath.row].objectID)
            print("=========",self.data[indexPath.row].objectID)
            
            //Delete
            self.mealService.delete(id: self.data[indexPath.row].objectID)
            self.data.remove(at: indexPath.row)
            self.mealService.saveChange()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            let editMeal = self.data[indexPath.row]
            
            self.performSegue(withIdentifier: "showEdit", sender: editMeal)
            
        }
        
        deleteButton.backgroundColor = .red
        editButton.backgroundColor = .blue
        
        return [deleteButton,editButton]
    }
}
