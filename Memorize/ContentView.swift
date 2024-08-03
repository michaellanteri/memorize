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
    //Vars in views are IMMUTABLE after initalizing, can't change isFaceUp directly
    //@State is only for small temporary things--game logic should not be done in a view
    //@State is a pointer, so isFaceUp can point to different things while being immutable
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            //Type inference
            let base = RoundedRectangle(cornerRadius: 12.0)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text("🥳").font(.largeTitle)
            } else {
                base.fill()
            }
        }
        .onTapGesture {
            //Same as isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}


























#Preview {
    ContentView()
}
