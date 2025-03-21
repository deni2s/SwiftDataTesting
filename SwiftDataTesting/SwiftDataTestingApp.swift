//
//  SwiftDataTestingApp.swift
//  SwiftDataTesting
//
//  Created by Deniss Fedotovs on 11.3.2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataTestingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Car.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
