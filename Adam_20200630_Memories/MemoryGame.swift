//
//  MemoryGame.swift
//  Adam_20200630_Memories
//
//  Created by Adam on 2020/7/1.
//  Copyright © 2020 Adam. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        print("chosen card: \(card)")
        let index = self.index(of: card)
        self.cards[index].isFaceUp = !self.cards[index].isFaceUp
    }
    
    func index(of card: Card) -> Int {
        for cardIndex in 0..<self.cards.count {
            if self.cards[cardIndex].id == card.id {
                return cardIndex
            }
        }
        return 0 // TODO: bogus!
    }
    
    init(numberOfPairsOfCards: Int, cardContentOfFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairOfIndex in 0..<numberOfPairsOfCards {
            let content = cardContentOfFactory(pairOfIndex)
            cards.append(Card(id: pairOfIndex*2, content: content))
            cards.append(Card(id: pairOfIndex*2+1, content: content))
        }
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
    }
    
}
