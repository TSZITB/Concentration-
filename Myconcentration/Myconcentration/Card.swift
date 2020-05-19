//
//  Card.swift
//  Myconcentration
//
//  Created by zhuwenhong on 2020/5/19.
//  Copyright © 2020 zhuwenhong. All rights reserved.
//

import Foundation

struct Card
{
    var isMatched = false
    var isFaceUp = false
    var identifier = 0
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
