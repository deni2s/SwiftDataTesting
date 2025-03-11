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
    @Attribute(.unique)
    var name: String
    var carData: CarData

    init(name: String, carData: CarData) {
        self.name = name
        self.carData = carData
    }

    func copy() -> Car {
        Car(
            name: "temporaryNewName",
            carData: carData
        )
    }
}

@Model
class CarData: Identifiable {
    var id: UUID = UUID()
    var features: [Feature]

    init(id: UUID = UUID(), features: [Feature]) {
        self.id = id
        self.features = features
    }

   func copy() -> CarData {
       CarData(
            id: UUID(),
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
        inverse: \CarData.features
    )
    private(set) var carDatas: [CarData]?

    init(id: Int, name: String, carDatas: [CarData]? = nil) {
        self.id = id
        self.name = name
        self.carDatas = carDatas
    }
}
