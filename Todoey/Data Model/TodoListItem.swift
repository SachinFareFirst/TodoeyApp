//
//  TodoListItem.swift
//  Todoey
//
//  Created by Sachin H K on 26/08/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class TodoListItem: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date?
    var parentCategory = LinkingObjects(fromType: CategoryItem.self, property: "items")
    //Category.self is Object.Type
//    In the TodoListItem class, you use LinkingObjects to create a reverse relationship. This allows you to access the parent CategoryItem from a TodoListItem instance
}
