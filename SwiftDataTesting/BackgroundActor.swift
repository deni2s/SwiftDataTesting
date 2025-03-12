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
        try! modelContext.delete(model: Car.self)
        let car = Car(
            name: "BMW",
            features: [
                Feature(id: 1, name: "green"),
                Feature(id: 2, name: "slow")
            ]
        )
        modelContext.insert(car)
        try! modelContext.save()
    }

    func test(name: String = "BMW") {
        let fetchDescriptor = FetchDescriptor<Car>(
            predicate: #Predicate<Car> {
                car in
                true
            }
        )
        let cars = try! modelContext.fetch(
            fetchDescriptor
        )
        let car = cars.first!
        print("expected car features:\n\t", car.features.map{$0.name}) //prints ["slow", "green"] - expected
        let newCar = car.copy()
        print("expected newCar features:\n\t", newCar.features.map{$0.name}) //prints ["slow", "green"] - expected
        modelContext.insert(newCar)
//        newCar.features = car.features //this workaround helps!
        print("UNEXPECTED newCar features:\n\t", newCar.features.map{$0.name}) //prints ["slow", "green", "slow", "green"] - UNEXPECTED!

        /*some code planned here modifying newCar.features, but they are wrong here causing issues,
for example finding first expected green value and removing it will still keep the unexpected duplicate
(unless iterating over all arrays to delete all unexpected duplicates - not optimal and sloooooow).

        for i in 0..<newCar.features.count {
            if newCar.features[i].name == "green" {
                newCar.features.remove(at: i)
                print("this should remove the green feature")
                break //feature expected to be removed -> no need to continue iterations
            }
        }
         */

        try! modelContext.save()
        print("after save newCar features:\n\t", newCar.features.map{$0.name}) //prints ["slow", "green"] - self-auto-healed???
    }
}

