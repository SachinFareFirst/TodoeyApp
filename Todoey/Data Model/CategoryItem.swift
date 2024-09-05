//
//  Category.swift
//  Todoey
//
//  Created by Sachin H K on 26/08/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryItem : Object {
   @objc dynamic var name : String = ""
    @objc dynamic var color : String = ""
    var items = List<TodoListItem>() 
}
