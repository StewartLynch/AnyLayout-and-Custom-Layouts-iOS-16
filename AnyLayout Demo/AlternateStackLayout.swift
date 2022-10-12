//
// Created for AnyLayout Demo
// by Stewart Lynch on 2022-10-11
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

struct AlternateStackLayout: Layout {
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let allWidths = subviewSizes.map { $0.width }
        let evenWidthMax = allWidths.enumerated()
            .filter {$0.0.isMultiple(of: 2)}
            .map {$0.1}
            .max()
        
        let oddWidthMax = allWidths.enumerated()
            .filter {!$0.0.isMultiple(of: 2)}
            .map {$0.1}
            .max()
        
        let totalHeight = subviewSizes.map {$0.height}
            .reduce(0, +)
        
        return CGSize(width: evenWidthMax! + (oddWidthMax ?? 0), height: totalHeight)
        
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        let subviewSizes = subviews.map { $0.sizeThatFits(.unspecified) }
        let allWidths = subviewSizes.map { $0.width }
        let evenWidthMax = allWidths.enumerated()
            .filter {$0.0.isMultiple(of: 2)}
            .map {$0.1}
            .max()
        
        let evenX = bounds.minX
        let oddX = bounds.minX + evenWidthMax!
        
        var y = bounds.minY
        
        for (index, subview) in subviews.enumerated() {
            let subviewSize = subviewSizes[index]
            let proposedSize = ProposedViewSize(width: subviewSize.width, height: subviewSize.height)
            if index.isMultiple(of: 2) {
                subview.place(at: CGPoint(x: evenX, y: y),
                              anchor: .topLeading,
                              proposal: proposedSize)
            } else {
                subview.place(at: CGPoint(x: oddX, y: y),
                              anchor: .topLeading,
                              proposal: proposedSize)
            }
            y += subviewSize.height
        }
    }
    
    
}
