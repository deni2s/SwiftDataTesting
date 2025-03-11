//
//  BackgroundActor.swift
//
//  Created by Deniss Fedotovs on 3.3.2025.
//


import Foundation
import SwiftData

@ModelActor
actor BackgroundActor: Sendable {

    func prepareData() {
        let feature1 = Feature(id: 1, name: "green")

        let carData1 = CarData(features: [feature1])
        let car1 = Car(name: "BMW", carData: carData1)
        modelContext.insert(car1)

        try! modelContext.save()
    }

    func test(name: String = "BMW") {
        let fetchDescriptor = FetchDescriptor<Car>(
            predicate: #Predicate<Car> {
                car in
                car.name == name
            }
        )
        let cars = try! modelContext.fetch(
            fetchDescriptor
        )
        let car = cars.first!
        print("expected car features:\n\t", car.carData.features.map{$0.name}) //prints ["green"] - expected
        let newCar = car.copy()
        newCar.name = "Another car"
        newCar.carData = car.carData.copy()
        print("expected newCar features:\n\t", newCar.carData.features.map{$0.name}) //prints ["green"] - expected
        modelContext.insert(newCar)
        print("UNEXPECTED newCar features:\n\t", newCar.carData.features.map{$0.name}) //prints ["green", "green"] - UNEXPECTED!

        /*some code planned here modifying newCar.featuresA, but they are wrong here causing issues,
for example finding first expected green value and removing it will still keep the unexpected duplicate
(unless iterating over all arrays to delete all unexpected duplicates - not optimal and sloooooow).

        for i in 0..<newCar.carData.features.count {
            if newCar.carData.features[i].name == "green" {
                newCar.carData.features.remove(at: i)
                print("this should remove the green feature")
                break //feature expected to be removed -> no need to continue iterations
            }
        }
         */

        try! modelContext.save()
        print("after save newCar features:\n\t", newCar.carData.features.map{$0.name}) //prints ["green"] - self-auto-healed???
    }
}

