////
////  TableViewsFile.swift
////  Todoey
////
////  Created by Sachin H K on 17/08/24.
////  Copyright © 2024 App Brewery. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class UITableViewController : UITableViewController {
//    
//    var todoObject = TodoListViewController()
//    //MARK - Tableview DataSource Method
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoObject.itemArray.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//       cell.textLabel?.text = itemArray[indexPath.row]
////        let customAccessoryView = UIImageView(image: UIImage(systemName: "star"))
////        cell.accessoryView = customAccessoryView
//        return cell
//    }
// 
//    //tableview
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            itemArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//        else if editingStyle == .insert {
//            
//        }
//    }
//    
//    
//    
//    
//    //Mark TableView Delegate Methods
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("tapped cell number \(itemArray[indexPath.row]),\(indexPath.row)")
//   
//        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//          
////        if tableView.cellForRow(at: indexPath)?.accessoryType == .disclosureIndicator {
////            tableView.cellForRow(at: indexPath)?.accessoryType = .none
////        }
////        else {
////            tableView.cellForRow(at: indexPath)?.accessoryType = customAccessoryView
////        }
//        
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//    
//}
