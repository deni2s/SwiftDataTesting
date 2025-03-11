//
//  Item.swift
//  SwiftDataTesting
//
//  Created by Deniss Fedotovs on 11.3.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
