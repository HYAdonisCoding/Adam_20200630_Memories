//
//  EmojiArt.swift
//  Adam_20201127_EmojiArt
//
//  Created by Adam on 2020/11/27.
//  Copyright © 2020 Adam. All rights reserved.
//

import Foundation

struct EmojiArt: Codable{
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable {
        var id: Int
        
        let text: String
        var x: Int
        var y: Int
        var size: Int
        
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = x
            self.size = size
            
        }
        
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    init?(json: Data?) {
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        } else {
            return nil
        }
    }
    init() {    }
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: x, y: y, size: size))
    }
    
}
