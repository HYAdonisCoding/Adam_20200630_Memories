//
//  Array+Identifiable.swift
//  Adam_20200630_Memories
//
//  Created by Adam on 2020/7/1.
//  Copyright © 2020 Adam. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int {
        for cardIndex in 0..<self.count {
            if self[cardIndex].id == matching.id {
                return cardIndex
            }
        }
        return 0 // TODO: bogus!
    }
}
