//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoolColourLibrary
import RealmSwift

class TodoListViewController: SwipeTableViewController {

    var todoItem : Results<TodoListItem>?
   
    let realm = try! Realm()

    var selectedCategory : CategoryItem? {
        didSet {
            //initially it will not cal this function
            //as soon as selectedCategory set the value it will call that function
            loadItem()
        }
    }

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let colorHex = selectedCategory?.color {
            title = selectedCategory?.name 
            guard let navBar = navigationController?.navigationBar else {
                return
            }
            
            if let navBarColour = UIColor(hexString: colorHex) { 
                
                navBar.barTintColor = navBarColour
                navBar.tintColor = ContrastColorOf(navBarColour, isflat: true)
                navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(navBarColour, isflat: true)]
                // searchBar.barTintColor = UIColor(hexString: colorHex) }
            }
            
        }}

    
    @IBAction func addButton(_ sender: Any) {
        
        var textfieldValue = UITextField()
        
  /* creating pop box */
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: UIAlertController.Style.alert)
        
  /* creating action for popbutton */
        let action1 = UIAlertAction(title: "Add Item", style: UIAlertAction.Style.default
        ) { (action) in

            //creating a new object
            if let currentCategory = self.selectedCategory {
            do {
                try self.realm.write{
                        let newItem = TodoListItem()
                        newItem.title = textfieldValue.text!
                        newItem.date = Date()
                        currentCategory.items.append(newItem)
                    print(newItem.title)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
           
            self.tableView.reloadData()
        }
        
        /*this below code triggere only when textfield added to alert*/
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Todo Item"
       print("for alert textfield is added")
            
            //it is assign whole textfield with text value
          textfieldValue = alertTextField
            
        }
            alert.addAction(action1)
        present(alert, animated: true, completion: nil)
    }
    

    //MARK: - Tableview DataSource Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //here we are reusing the cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
       let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let cellItem = todoItem?[indexPath.row] {
            cell.textLabel?.text = cellItem.title
            
            //making gradient color
            if let color = UIColor(hexString: selectedCategory?.color ?? "A0A7C5")?.darken(percent:CGFloat(indexPath.row) / CGFloat(todoItem?.count ?? 1)) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, isflat: true)
                cell.accessoryType =  cellItem.done ?  .checkmark : .none
            }

        }
        else {
            cell.textLabel?.text = "No Items Added"
        }
        return cell
    }
 

    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = todoItem?[indexPath.row] {
            do {
                try realm.write {
                    //realm.delete(item)
                   item.done = !item.done
                }
            }
            catch {
                print("Error saving status",error.localizedDescription)
            }
        }
        tableView.reloadData()
       tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadItem() {
        todoItem = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    //MARK: -  Delete the data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        super.updateModel(at: indexPath)
        
        if let itemForDeletion = self.todoItem?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            }
            catch {
                print("Error deleting category, \(error)")
            }
        }
    }
}


//MARK: - Search Bar method
extension TodoListViewController : UISearchBarDelegate {
    //it will filter and sort the row cell and give the output
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItem = todoItem?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("every charcter it will trigger the field")
        
        if searchBar.text?.count == 0 {
            loadItem()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

