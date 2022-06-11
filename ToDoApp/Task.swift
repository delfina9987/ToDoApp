//
//  Task.swift
//  ToDoApp
//
//  Created by Delfina on 11/06/2022.
//

import Foundation
import RealmSwift

class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title = ""
    @Persisted var completed = false
}
