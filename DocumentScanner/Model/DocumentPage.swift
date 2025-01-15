//
//  DocumentPage.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 14/01/2025.
//

import Foundation
import SwiftData

@Model
class DocumentPage {
    var document: Document?
    var pageIndex: Int
    @Attribute(.externalStorage) // since it holds image data of each document page
    var pageData: Data
    
    init(document: Document? = nil, pageIndex: Int, pageData: Data) {
        self.document = document
        self.pageIndex = pageIndex
        self.pageData = pageData
    }
}
