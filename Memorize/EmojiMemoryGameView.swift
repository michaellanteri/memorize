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
    
    private let aspectRatio: CGFloat = 2/3
    
    //Can't make this private because in the View protocol, its not private
    var body: some View {
        VStack {
            newGame
            cards
            //value -- When any of our cards change, they will be animated
                .animation(.default, value: viewModel.cards)
            shuffle
            score
        }
        .padding()
    }
    
    var newGame: some View {
        VStack(spacing: 10) {
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game").font(.title)
            })
            Text("\(viewModel.theme.name)")
        }
    }
    
    //@ViewBuilder says look at contents of cards as if it were a ViewBuilder, even though it has stuff like let aspectRatio... etc.
    //This is usually implicit without stuff like that
    @ViewBuilder
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .foregroundColor(viewModel.color)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }
    
    var shuffle: some View {
        Button(action: {
            viewModel.shuffle()
        }, label: {
            Text("Shuffle").font(.title3)
        })
        .padding(10)
    }
    
    var score: some View {
        Text("Score: \(viewModel.score)")
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

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
