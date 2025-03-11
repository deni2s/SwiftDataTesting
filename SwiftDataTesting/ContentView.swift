//
//  ContentView.swift
//  SwiftDataTesting
//
//  Created by Deniss Fedotovs on 11.3.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    private let backgroundActor: BackgroundActor = BackgroundActor(
        modelContainer: SwiftDataTestingApp().sharedModelContainer
    )
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]

    var body: some View {
        Text("Look in the console")
            .task {
                await backgroundActor.prepareData()
                await backgroundActor.test()
            }
    }

}
