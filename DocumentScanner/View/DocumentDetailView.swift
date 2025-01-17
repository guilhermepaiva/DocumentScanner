//
//  DocumentDetailView.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 16/01/2025.
//

import SwiftUI
import PDFKit

struct DocumentDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var isLoading: Bool = false
    @State private var showFileMover: Bool = false
    @State private var fileURL: URL?
    
    var document: Document
    var body: some View {
        if let pages = document.pages?.sorted(by: { $0.pageIndex < $1.pageIndex }) {
            VStack(spacing: 10) {
                
                /// Header View
                HeaderView()
                    .padding([.horizontal, .top], 15)
                
                TabView {
                    ForEach(pages) { page in
                        if let image = UIImage(data: page.pageData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                .tabViewStyle(.page)
                
                /// Footer View
                FooterView()
                
            }
            .background(.black)
            .toolbarVisibility(.hidden, for: .navigationBar)
            .loadingScreen(status: $isLoading)
            .fileMover(isPresented: $showFileMover, file: fileURL) { result in
                // removing the temporary file
                guard let fileURL else { return }
                try? FileManager.default.removeItem(at: fileURL)
                self.fileURL = nil
            }
        }
    }
    
    @ViewBuilder
    private func HeaderView() -> some View {
        Text(document.name)
            .font(.callout)
            .foregroundStyle(.white)
            .hSpacing(.center)
            .overlay(alignment: .trailing) {
                // lock button
                Button(action: createAndShareDocument) {
                    Image(systemName: document.isLocked ? "lock.fill" : "lock.open.fill")
                        .font(.title3)
                        .foregroundStyle(.purple)
                }
            }
    }
    
    @ViewBuilder
    private func FooterView() -> some View {
        HStack {
            // share button
            Button {
                //
            } label: {
                Image(systemName: "square.and.arrow.up.fill")
                    .font(.title3)
                    .foregroundStyle(.purple)
            }
            
            Spacer(minLength: 8)
            
            Button {
                dismiss()
                Task { @MainActor in
                    try? await Task.sleep(for: .seconds(0.3))
                    context.delete(document)
                    try? context.save()
                }
            } label: {
                Image(systemName: "trash.fill")
                    .font(.title3)
                    .foregroundStyle(.red)
            }
        }
        .padding([.horizontal, .bottom], 15)
    }
    
    private func createAndShareDocument() {
        // converting a swiftdata document into a pdf document
        guard let pages = document.pages?.sorted(by: { $0.pageIndex < $1.pageIndex }) else { return }
        isLoading = true
        
        Task.detached(priority: .high) { [document] in
            try? await Task.sleep(for: .seconds(0.2))
            
            let pdfDocument = PDFDocument()
            for index in pages.indices {
                if let pageImage = UIImage(data: pages[index].pageData),
                   let pdfPage = PDFPage(image: pageImage) {
                    pdfDocument.insert(pdfPage, at: index)
                }
            }
            
            var pdfURL = FileManager.default.temporaryDirectory
            let fileName = "\(document.name).pdf"
            pdfURL.append(path: fileName)
            
            if pdfDocument.write(to: pdfURL) {
                await MainActor.run { [pdfURL] in
                    fileURL = pdfURL
                    showFileMover = true
                    isLoading = false
                }
                
            }
        }
    }
}

