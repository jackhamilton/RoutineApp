//
//  RoutineApp.swift
//  Routine
//
//  Created by Hamilton, Jack on 10/11/21.
//

import SwiftUI

@main
struct RoutineApp: App {
    
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
