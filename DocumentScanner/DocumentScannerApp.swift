//
//  DocumentScannerApp.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 14/01/2025.
//

import SwiftUI
import SwiftData

@main
struct DocumentScannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Document.self)
        }
    }
}
