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
    let emojis: Array<String> = ["👻","🎃","🕷️","😈","💀","🕸️","🧙‍♀️","🙀","👹","😱","☠️","🍭"]
    @State var cardCount: Int = 4
    
    //Body is of type View because its made up of many things (text, images, etc.)
    //Should always be 12 lines or less (20 is pushing it) for readability
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    //Implicit return: don't need to do "return LazyVGrid..." because its technically one line of code
    var cards: some View  {
        //LazyVGrid makes the space as small as possible, HStack makes it big as possible
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            //Can't do for loops in views, but can use ForEach
            //index is an argument of the closure
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        //Label is now a ViewBuilder, allowing a button to have multiple View elements
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    //Make other vars and not a new struct because its just a Button, not very fundamental like a CardView
    var cardRemover: some View {
        //Implicit return
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
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
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            //Need opacity for LazyVGrid
            //When isFaceUp is true, the front will show, and the back won't
            //When false, the back will show, and the front won't
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
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
