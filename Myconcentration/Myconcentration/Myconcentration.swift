//
//  Myconcentration.swift
//  Myconcentration
//
//  Created by zhuwenhong on 2020/5/19.
//  Copyright © 2020 zhuwenhong. All rights reserved.
//

import Foundation

class Myconcentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceCard : Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceCard, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceCard = nil
                
            }else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //todo shuffle the card
        for index in 1 ..< cards.count {
            let i = Int(arc4random()) % index
            if index != i {
                cards.swapAt(index, i)
            }
        }
        
    }
}
