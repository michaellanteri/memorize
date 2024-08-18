//
//  ContentView.swift
//  Memorize
//
//  Created by Michael Lanteri on 7/29/24.
//

import SwiftUI

//"Behaves like a..."
//EmojiMemoryGameView must behave like a View as WindowGroup in "MemorizeApp" file as "struct WindowGroup<Content> where Content : View"
//So, Content must be a View
//If EmojiMemoryGameView conforms to View, we unlock the ability (functionality) to use WindowGroup and ultimately see the UI
//That is the benefit of protocols and functional programming

struct EmojiMemoryGameView: View {
    //If something changed, redraw me
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            newGame
            ScrollView {
                cards
                //value -- When any of our cards change, they will be animated
                    .animation(.default, value: viewModel.cards)
            }
            shuffle
        }
        .padding()
    }
    
    var newGame: some View {
        Button(action: {
            viewModel.newGame()
        }, label: {
            Text("New Game").font(.title)
        })
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            //Each card (view) moves, not just change each emoji like viewModel.cards.indices would do
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
        .padding()
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            viewModel.shuffle()
        }
    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct Theme {
    let name: String
    let color: Color
    let symbol: String
    let emojis: [String]
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
