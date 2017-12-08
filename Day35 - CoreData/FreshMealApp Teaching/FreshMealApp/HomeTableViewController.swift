//
//  HomeTableViewController.swift
//  FreshMealApp
//
//  Created by KSHRD on 12/6/17.
//  Copyright © 2017 Kokpheng. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var data: [Meal] = []
    var mealService = MealService()
    
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
       
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        data = mealService.getAll()
        tableView.reloadData()
        print("\(data)")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        cell.configurCell(with: data[indexPath.row])

        return cell
    }
 
    func setupTableView(){
        // dynamic row
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Register Custom Cell
        let nib = UINib(nibName: "MealTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MealTableViewCell")
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEdit" {
            print("==========ShowEdit =========")
            let dest = segue.destination as! AddEditMealTableViewController
            dest.mealHolder = sender as? Meal
        }else{
            print("==========Unknown =======")
        }

}
}
