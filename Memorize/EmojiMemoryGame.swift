//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Michael Lanteri on 8/8/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    //Static means specific to this type--so its only avaiable in this namespace
    private static let emojis = ["🐣","🐒","🐙","🦆","🦁","🐯","🐶","🐻","🐺","🐧","🦋","🦞","🐠"]
    
    //Must be static to call at initialization
    //Not global because private
    private static func createMemoryGame() -> MemoryGame<String>{
        return MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func newGame() {
        
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
