//
//  PregancyDemoApp.swift
//  PregancyDemo
//
//  Created by Angelo Sepulveda on 04/11/2025.
//

import SwiftUI
import CoreData

@main
struct PregancyDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
