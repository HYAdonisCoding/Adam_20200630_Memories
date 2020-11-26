//
//  EmojiMemoryGame.swift
//  Adam_20200630_Memories
//
//  Created by Adam on 2020/7/1.
//  Copyright © 2020 Adam. All rights reserved.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🕷", "🎃"//, "🐍"
        ]
        
        return MemoryGame(numberOfPairsOfCards: emojis.count) { index in
            return emojis[index]
        }
    }

    // MARK: - Access To The Model
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
    
    func restartGamd() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
