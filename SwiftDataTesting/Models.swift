//
//  Models.swift
//  SwiftDataTesting
//
//  Created by Deniss Fedotovs on 11.3.2025.
//

import Foundation
import SwiftData

@Model
class Car: Identifiable {
    var id: UUID = UUID()
    var name: String
    var features: [Feature]

    init(id: UUID = UUID(), name: String, features: [Feature]) {
        self.id = id
        self.name = name
        self.features = features
    }

   func copy() -> Car {
       Car(
            id: UUID(),
            name: name,
            features: features

        )
    }
}

@Model
class Feature: Identifiable {
    @Attribute(.unique)
    var id: Int

    @Attribute(.unique)
    var name: String

    @Relationship(
        deleteRule:.cascade,
        inverse: \Car.features
    )
    private(set) var cars: [Car]?

    init(id: Int, name: String, cars: [Car]? = nil) {
        self.id = id
        self.name = name
        self.cars = cars
    }
}
