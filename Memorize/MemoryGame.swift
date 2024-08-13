//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Michael Lanteri on 8/8/24.
//

import Foundation

//CardContent is a "don't care"
//Wider scope you put it, the more it can apply to other sub-structs
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
    
}
