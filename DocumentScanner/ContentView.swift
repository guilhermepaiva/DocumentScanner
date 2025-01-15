//
//  ContentView.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 14/01/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("showIntroView") private var showIntroView = true

    var body: some View {
        Home()
            .sheet (isPresented: $showIntroView) {
                IntroScreen()
                    .interactiveDismissDisabled()
            }
    }

    
}

#Preview {
    ContentView()
        
}
