//
//  Item.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 14/01/2025.
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
