//
//  MemoryGame.swift
//  Adam_20200630_Memories
//
//  Created by Adam on 2020/7/1.
//  Copyright © 2020 Adam. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.only
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    
    mutating func choose(card: Card) {
        print("chosen card: \(card)")
        if let chooseIndex = cards.firstIndex(matching: card), !cards[chooseIndex].isFaceUp, !cards[chooseIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chooseIndex].content == cards[potentialMatchIndex].content {
                    cards[chooseIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chooseIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = chooseIndex
            }
        }
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
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
    
}
