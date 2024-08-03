//
//  ContentView.swift
//  Memorize
//
//  Created by Michael Lanteri on 7/29/24.
//

import SwiftUI

struct ContentView: View {
    //Body is of type View because its made up of many things (text, images, etc.)
    var body: some View {
        HStack {
            //Building views out of other views
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12.0)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12.0)
                    .strokeBorder(lineWidth: 2)
                Text("🥳").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12.0)
            }
        }
    }
}


























#Preview {
    ContentView()
}
