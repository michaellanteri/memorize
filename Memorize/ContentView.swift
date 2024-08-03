//
//  ContentView.swift
//  Memorize
//
//  Created by Michael Lanteri on 7/29/24.
//

import SwiftUI

struct ContentView: View {
    //Array is a generic type, so you can have anything in it
    //We are specifying it is of String elements
    //Can also do [String] instead of Array<String> (preferred way)
    let emojis: Array<String> = ["👻","🎃","🕷️","😈"]
    
    //Body is of type View because its made up of many things (text, images, etc.)
    var body: some View {
        HStack {
            //Can't do for loops in views, but can use ForEach
            //index is an argument of the closure
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let content: String
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
                Text(content).font(.largeTitle)
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
