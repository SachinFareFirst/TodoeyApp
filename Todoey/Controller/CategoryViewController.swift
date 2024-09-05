//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Sachin H K on 24/08/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import CoolColourLibrary


class CategoryViewController: SwipeTableViewController {

        let realm = try! Realm()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        loadCategories()
        tableView.rowHeight = 60.0
       // tableView.separatorColor = .black
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        guard let navBar = navigationController?.navigationBar else {
            return
        }
        navBar.backgroundColor = UIColor(hexString: "1D9BF6")
    }
    //It’s meant to hold a reference to a collection of CategoryItem objects.
    var categories: Results<CategoryItem>?

// MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //here we are overridding the cell
        /*when we call this function first it goes the swipetableview cell and comes to this cell*/
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let cellItem = categories?[indexPath.row].name ?? "No Categories Added yet"
        cell.textLabel?.text = cellItem
      //  cell.backgroundColor = UIColor.randomflat()
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "A0A7C5")
        
        
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, isflat: true)
        return cell
    }
    
    
    //MARK: - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("after preapre it will trigger")
        performSegue(withIdentifier: "segueItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       // print("first it will trigger before the performsegue")
        let destionVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
                    destionVC.selectedCategory = categories?[indexPath.row]
                }
    }
    
// MARK: - Data Manipulation Methods
    
    @IBAction func addButtonPressed(_ sender: Any) {
      
        var textFieldValue = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = CategoryItem()
            newCategory.name = textFieldValue.text ?? "No value found"
            newCategory.color = UIColor.randomflat().hexValue()
            self.saveCategories(category: newCategory)
            
        }
            alert.addAction(action)
        alert.addTextField { 
            (field) in
            textFieldValue = field
            textFieldValue.placeholder = "Add a New Category"
        }
        present(alert,animated: true,completion: nil)
        //self.saveCategories()
    }
    
    //MARK: - For Saving the data
    func saveCategories(category: CategoryItem) {
        do {
            /* save the item  */
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving context",error)
        }
        
        //it will load the tableview to add the item
        tableView.reloadData()
    }
    
    //MARK: - For loading the data
    //here we have given default parameter value
    func loadCategories() {
        /* fetch the item */
        //returns all object of the given type stored in the realm
         categories = realm.objects(CategoryItem.self)
        print(categories ?? "nothing")
        //it will call all the datasource methods
        //and returns num of categories
        tableView.reloadData()
    }
    
    //MARK: -  Delete the data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        
        if let categoryforDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryforDeletion)
                }
            }
            catch {
                print("Error deleting category, \(error)")
            }
        }
    }
}

