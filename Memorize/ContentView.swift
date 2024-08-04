//
//  ContentView.swift
//  Memorize
//
//  Created by Michael Lanteri on 7/29/24.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = []
    @State var cardColor: Color = .white
    
    var body: some View {
        VStack {
            title
            ScrollView {
                cards
            }
            themeChoices
        }
        .padding()
    }
    
    var title: some View {
        Text("Memorize!").font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 45))]) {
            ForEach(0..<emojis.count, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardColor)
        .padding()
    }
    
    var themeChoices: some View {
        HStack(alignment: .lastTextBaseline, spacing: 50) {
            animalTheme
            foodTheme
            flagTheme
        }
        .padding()
    }
    
    func themeChoice(name: String, color: Color, symbol: String, entities: [String]) -> some View {
        Button(action: {
            let shuffledEntities = entities.shuffled()
            let cardCount = Int.random(in: 2...entities.count)
            let randNumEntities = shuffledEntities[0..<cardCount]
            emojis = (randNumEntities+randNumEntities).shuffled()
            cardColor = color
        }, label: {
            VStack(spacing: 5) {
                Image(systemName: symbol).font(.title)
                Text(name).font(.caption)
            }
        })
    }
    
    var animalTheme: some View {
        themeChoice(name: "Animals", color: .orange, symbol: "dog.fill", entities: ["🐣","🐒","🐙","🦆","🦁","🐯","🐶","🐻","🐺","🐧","🦋","🦞","🐠"])
    }
    
    var foodTheme: some View {
        themeChoice(name: "Food", color: .green, symbol: "carrot.fill", entities: ["🥐","🥕","🍌","🥞","🥭","🫐","🥒","🍑","🥥"])
    }
    
    var flagTheme: some View {
        themeChoice(name: "Flags", color: .red, symbol: "flag.fill", entities: ["🇦🇺","🇨🇦","🇬🇷","🇵🇭","🇸🇪","🇿🇦","🇺🇸","🇧🇷","🇹🇩","🇧🇬","🇬🇲","🇱🇧","🇵🇱","🇰🇷","🇮🇹","🇨🇳","🇪🇺"])
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12.0)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
