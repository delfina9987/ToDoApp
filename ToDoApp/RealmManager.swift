//
//  RealmManager.swift
//  ToDoApp
//
//  Created by Delfina on 11/06/2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published private(set) var tasks: [Task] = []
    
    init()
    {
        openRealm()
        getTasks()
    }
    
    func openRealm()
    {
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm()
        }
        catch
        {
            print("Error opening Realm: \(error)")
        }
    }
    
    // add task
    func addTask(taskTitle: String)
    {
        if let localRealm = localRealm
        {
            do
            {
                try localRealm.write
                {
                    let newTask = Task(value: ["title": taskTitle, "completed": false])
                    localRealm.add(newTask)
                    getTasks()
                    print("Added new task to Realm: \(newTask)")
                }
            }
            catch
            {
                print("Error adding task to Realm: \(error)")
            }
        }
    }
    
    // read task
    func getTasks()
    {
        if let localRealm = localRealm {
            let allTasks = localRealm.objects(Task.self).sorted(byKeyPath: "completed")
            tasks = []
            allTasks.forEach { task in
                tasks.append(task)
            }
        }
    }
    
    // update task
    func updateTask(id: ObjectId, completed: Bool)
    {
        if let localRealm = localRealm {
            do
            {
                let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else { return }
                
                try localRealm.write
                {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("Updated task with id \(id)! Compleed status: \(completed)")
                }
            }
            
            catch
            {
                print("Error updating task \(id) to Realm: \(error)")
            }
            
        }
    }
    
    // delete task
    func deleteTask(id: ObjectId)
    {
        if let localRealm = localRealm {
            do
            {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToDelete.isEmpty else { return }
                
                try localRealm.write
                {
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("Deleted task with id \(id)")
                }
            }
            
            catch
            {
                print("Error deleting task \(id) to Realm: \(error)")
            }
            
        }
    }
    
}
