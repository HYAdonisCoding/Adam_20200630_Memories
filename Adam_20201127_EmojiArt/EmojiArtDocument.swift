//
//  EmojiArtDocument.swift
//  Adam_20201127_EmojiArt
//
//  Created by Adam on 2020/11/27.
//  Copyright © 2020 Adam. All rights reserved.
//

import SwiftUI

class EmojiArtDocument: ObservableObject {
    
    static let palette: String = "😈🐶🦖🐢🦟🐝🐳🌲🌍🌈🔥🍎🌽"
    
    //@Published //workaround for property observer problem with property warppers
    private var emojiArt: EmojiArt = EmojiArt() {
        willSet {
            objectWillChange.send()
        }
        didSet {
//            print("new json = \(emojiArt.json?.utf8 ?? "nil")")
            UserDefaults.standard.setValue(emojiArt.json, forKey: EmojiArtDocument.untitled)
        }
    }
    private static let untitled = "EmojiArtDocument.Untitled"
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        fetchBackgroundImageData()
    }
    
    @Published private(set) var backgroundImage: UIImage?
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    
    // MARK: - Intent(s)
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale ).rounded(.toNearestOrEven))
            
        }
    }
    
    func setBackgroundURL(_ url: URL?) {
        emojiArt.backgroundURL = url?.imageURL
        
        fetchBackgroundImageData()
    }
    private func fetchBackgroundImageData() {
        if let url = self.emojiArt.backgroundURL {
            backgroundImage = nil
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let imageData = data else {
                    print("no data back")
                    return
                }
                // maybe try dispatch to main
                DispatchQueue.main.async {
                    if url == self.emojiArt.backgroundURL {
                        self.backgroundImage = UIImage(data: imageData)
                    }
                }
            }
            task.resume()
        }
//            DispatchQueue.global(qos: .userInitiated).async {
//                if let imageData = try? Data(contentsOf: url) {
//                    DispatchQueue.main.async {
//                        if url == self.emojiArt.backgroundURL {
//                            self.backgroundImage = UIImage(data: imageData)
//                        }
//                    }
//                }
//            }
//
//        }
    }
}

extension EmojiArt.Emoji {
    var fontSize: CGFloat { CGFloat(self.size) }
    var location: CGPoint { CGPoint(x: CGFloat(x), y: CGFloat(y)) }
}
