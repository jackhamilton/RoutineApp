//
//  PersistenceController.swift
//  Routine
//
//  Created by Hamilton, Jack on 10/14/21.
//

import Foundation
import CoreData

struct PersistenceController {
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        for i in 0..<10 {
            let routine = RoutineStore(context: controller.container.viewContext)
            routine.name = "Example Routine \(i)"
            routine.timeStart = "\(Int.random(in: 1...12)):\(Int.random(in: 10...60))\(Int.random(in: 1...2) == 1 ? "AM" : "PM")"
            routine.timeEnd = routine.timeStart
        }

        return controller
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Data")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
