//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Michael Lanteri on 8/8/24.
//

import Foundation

//CardContent is a generic
struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var score: Int
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
        
        score = 0
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            //.only is our extension of an Array
            cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            //Sets all cards except newValue face down
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(_ card: Card) {
        //Cards passed in parameters are copies, as they are value types
        //Need another method that finds the index to update the cards array
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                //First card selected, indexOfThe... will be nil, so it will be set to chosenIndex in the else
                //Second card, new chosenIndex will be compared to indexOfThe... (potentialMatchIndex)
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    } else {
                        if cards[chosenIndex].wasSeen {
                            score -= 1
                        }
                        if cards[potentialMatchIndex].wasSeen {
                            score -= 1
                        }
                    }
                    cards[chosenIndex].wasSeen = true
                    cards[potentialMatchIndex].wasSeen = true
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    //Equatable is synthesized
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        var wasSeen = false
        
        var id: String
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        //Can say count and first because inside an Array type
        return count == 1 ? first : nil
    }
}

struct Theme<CardContent> where CardContent: Equatable {
    var name: String
    var emoji: [CardContent]
    var numberOfPairs: Int
    var color: String
}
