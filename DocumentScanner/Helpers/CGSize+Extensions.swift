//
//  CGSize+Extensions.swift
//  DocumentScanner
//
//  Created by Guilherme Paiva on 16/01/2025.
//

import SwiftUI

extension CGSize {
    // this function will return a new size that fits the given size in an aspect ratio
    func aspectFit(_ to: CGSize) -> CGSize {
        let scaleX = to.width / self.width
        let scaleY = to.height / self.height
        
        let aspectRatio = min(scaleX, scaleY)
        return .init(width: aspectRatio * width, height: aspectRatio * height)
    }
}
