//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Michael Lanteri on 8/29/24.
//

import SwiftUI

//This is basically how HStack, VStack, etc. work
//<Item: Identifiable> same as including "where Item: Identifiable"
struct AspectVGrid<Item: Identifiable, ItemView: View>: View{
    var items: [Item]
    var aspectRatio: CGFloat = 1
    //Can't do -> View because its a protocol, not a concrete type
    var content: (Item) -> ItemView
    
    //Need @escaping because we're storing the closure and calling it later, after the init function returns
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        //Use self when two things have the same name
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                    //Put . before things because they're enums, like .black, .fit, etc.
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
    
}
