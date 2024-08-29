//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Michael Lanteri on 8/8/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    private static var themes = [Theme(name: "Animals", emoji: ["🐶","🐱","🐒","🐼","🐌","🪰","🐝","🐙","🦇"], numberOfPairs: 9, color: "purple"),
        Theme(name: "Food", emoji: ["🍊","🍑","🍓","🍉","🥑","🍠","🍍","🥨","🥖"], numberOfPairs: 9, color: "orange"),
        Theme(name: "Sports", emoji: ["⚾️","🎾","🏉","🥏","🏀","⚽️","🏈","🥎","🏐","🏓","🏒"], numberOfPairs: 11, color: "blue"),
        Theme(name: "Faces", emoji: ["🥰","😚","☹️","🥵","🤓","😎","😇","🥲","😅","😂","🤩","🥳","🥸"], numberOfPairs: 13, color: "yellow"),
        Theme(name: "Vehicles", emoji: ["🚗","🚕","🚙","🚌","🚎","🏎️","🚓","🚑","🚒","🚜","🛵","🚁","🚀","🛳️","🚢"], numberOfPairs: 15, color: "red"),
        Theme(name: "Nature", emoji: ["🌲","🍄","🌾","🍁","🌱","🐚","🌺","🌷","🌞","🌈","🌚","☄️","❄️","🌧️"], numberOfPairs: 14, color: "green")]
    
    private static func createMemoryGame(ofTheme theme: Theme<String>) -> MemoryGame<String> {
        let themeEmoji = theme.emoji.shuffled()
        
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if themeEmoji.indices.contains(pairIndex) {
                return themeEmoji[pairIndex]
            }
            return "⁉️"
        }
    }
        
    @Published private var model: MemoryGame<String>
    var theme: Theme<String>
    
    init() {
        if let randTheme = EmojiMemoryGame.themes.randomElement() {
            theme = randTheme
        }
        else {
            theme = Theme(name: "Error", emoji: ["⁉️"], numberOfPairs: 1, color: "red")
        }
        
        model = EmojiMemoryGame.createMemoryGame(ofTheme: theme)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var color: Color {
        switch theme.color {
        case "red":
            return .red
        case "orange":
            return .orange
        case "yellow":
            return .yellow
        case "green":
            return .green
        case "blue":
            return .blue
        case "purple":
            return .purple
        default:
            return .black
        }
    }
    
    // MARK: - Intents
    
    func newGame() {
        if let randTheme = EmojiMemoryGame.themes.randomElement() {
            theme = randTheme
        }
        else {
            theme = Theme(name: "Error", emoji: ["⁉️"], numberOfPairs: 1, color: "red")
        }
        model = EmojiMemoryGame.createMemoryGame(ofTheme: theme)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
