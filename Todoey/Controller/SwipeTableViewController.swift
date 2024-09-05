//
//  SwipeTableViewController.swift
//  Todoey
//
//  Created by Sachin H K on 29/08/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import SwipeCellKit


class SwipeTableViewController: UITableViewController,SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        
    }
     //TableView DataSource Method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //here we are reusing the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
         cell.delegate = self
        return cell
    }
    

        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
            guard orientation == .right else { return nil }

            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                print("print Delete cell")
                // handle action by updating model with deletion
                self.updateModel(at: indexPath)
            }

            // customize the action appearance
            deleteAction.image = UIImage(named: "delete-icon")

            return [deleteAction]
        }
        func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeTableOptions {
            var options = SwipeTableOptions()
            options.expansionStyle = .destructive
            return options
        }
    
    func updateModel(at indexPath: IndexPath) {
        // Update our data model
        print("main thing is in swipe table")
    }
        
    }


