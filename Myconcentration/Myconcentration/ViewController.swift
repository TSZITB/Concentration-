//
//  ViewController.swift
//  Myconcentration
//
//  Created by zhuwenhong on 2020/5/19.
//  Copyright © 2020 zhuwenhong. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    override func viewDidLoad() {
        for bt in cardButtons {
            bt.layer.cornerRadius = 10
        }
        
        FlipCountLabel.layer.cornerRadius = 10
        FlipCountLabel.clipsToBounds = true
        Score.layer.cornerRadius = 10
        Score.clipsToBounds = true
        
        restartButton.layer.cornerRadius = 34
        
        
        let emojiChoice = ([animals] + [sports] + [faces]).randomElement()!
        
        setEmojiChoice(for: emojiChoice)
        
    }
    
    lazy var game = Myconcentration(numberOfPairsOfCards: (cardButtons.count + 1)/2)
    
    var flipCount = 0 {
        didSet {
            FlipCountLabel.text = "Flip Count: \(flipCount)"
        }
    }
    var score = 0 {
        didSet {
            Score.text = "Score : \(score)"
        }
    }
    
    var animals = ["🐸", "🐤", "🦜", "🐶", "🙀", "🐖", "🙊", "🦞", "🐌"]
    var sports = ["🏀", "🏈", "🏉", "🏐", "🎱", "🏓", "🏸", "🥎", "⚽️"]
    var faces = ["🤓", "😎", "🥶", "🤬", "🙄", "🥺", "😭", "😱", "🙃"]
    
    var emoji = [Int: String]()
    
    
    var emojiChoice = [String]()
    
    
    @IBOutlet weak var FlipCountLabel: UILabel!
    @IBOutlet weak var Score: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchButton(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            UpdateViewFromModel()
        }else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func restartGame(_ sender: UIButton) {
        flipCount = 0
        score = 0
        
        for index in cardButtons.indices {
            game.cards[index].isFaceUp = false
            game.cards[index].isMatched = false
            cardButtons[index].backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cardButtons[index].setTitle("", for: UIControl.State.normal)
        }
    }
    
    
    
    
    func UpdateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ?#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            }
            
        }
    }
    
    
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoice.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count)))
            emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    func setEmojiChoice(for emoji: [String]){
        self.emojiChoice = emoji
    }
}

