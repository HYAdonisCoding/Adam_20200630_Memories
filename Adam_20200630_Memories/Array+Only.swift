//
//  Array+Only.swift
//  Adam_20200630_Memories
//
//  Created by Adam on 2020/7/2.
//  Copyright © 2020 Adam. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
    
}
