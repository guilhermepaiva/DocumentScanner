//
//  Document.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 14/01/2025.
//

import Foundation
import SwiftData

@Model
class Document {
    var name: String
    var createdAt: Date = Date()
    @Relationship(deleteRule: .cascade, inverse: \DocumentPage.document)
    var pages: [DocumentPage]?
    var isLocked: Bool = false
    var uniqueViewID: String = UUID().uuidString // for zoom transition
    
    init(name: String, pages: [DocumentPage]? = nil) {
        self.name = name
        self.pages = pages
    }
}
