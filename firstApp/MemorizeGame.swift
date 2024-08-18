//
//  MemorizeGame.swift
//  firstApp
//
//  Created by  Федор Попко on 18.08.2024.
//

import Foundation

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
