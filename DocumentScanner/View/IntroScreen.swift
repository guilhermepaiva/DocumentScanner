//
//  IntroScreen.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 14/01/2025.
//

import SwiftUI

struct IntroScreen: View {
    @AppStorage("showIntroView") private var showIntroView = true
    
    var body: some View {
        VStack(spacing: 15) {
            Text("What's new in \nDocument Scanner")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top, 65)
                .padding(.bottom, 35)
            
            /// Points
            VStack(alignment: .leading, spacing: 25) {
                PointView(
                    title: "Scan Documents",
                    image: "doc.text.viewfinder",
                    description: "Scan your documents with ease"
                )
                PointView(
                    title: "Save Documents",
                    image: "tray.full.fill",
                    description: "Persist scanned documents on your device"
                )
                PointView(
                    title: "Lock Documents",
                    image: "faceid",
                    description: "Secure your documents with Face ID"
                )
            }
            .padding(.horizontal, 25)
            
            Spacer(minLength: 0)
            
            /// Continue Button
            Button {
                showIntroView = false
            } label: {
                Text("Start Using Document Scanner")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .hSpacing(.center)
                    .padding(.vertical, 15)
                    .background(.purple.gradient, in: .capsule)
                
            }
        }
        .padding(15)
    }
    
    @ViewBuilder
    private func PointView(title: String, image: String, description: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .font(.largeTitle)
                .foregroundStyle(.purple)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(description)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
        }
    }
        
}

#Preview {
    IntroScreen()
}
