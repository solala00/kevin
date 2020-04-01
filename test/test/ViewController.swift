//
//  ViewController.swift
//  test
//
//  Created by student on 2020/3/30.
//  Copyright © 2020年 student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var emojiChoices = ["⚽️","🍡","🍩","🏑","🏈","🏀","😀","🐱"]
    var emoji = [Int:String]()
    
    @IBOutlet var cards: [UIButton]!
    lazy var game = MatchingGame(numberOfPairsOfCards: (cards.count + 1) / 2 )
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count>0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    var flips = 0{
        didSet{
            //flipCounter.text = "Flips: \(flips)"
        }
    }
    @IBAction func filpCard(_ sender: UIButton) {
        print("f")
        if let cardNumber = cards.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("This card is not in the collection!")
        }
        flips+=1
    }
    
    
    @IBAction func startGame(_ sender: UIButton) {
        for index in cards.indices{
            cards[index].setTitle("", for: UIControlState.normal)
            cards[index].backgroundColor = #colorLiteral(red: 1, green: 0.7319397827, blue: 0.4253600333, alpha: 1)
        }
        emojiChoices = ["⚽️","🍡","🍩","🏑","🏈","🏀","😀","🐱"]
        game = MatchingGame(numberOfPairsOfCards: (cards.count + 1) / 2 )
    }
    
    func updateViewFromModel(){
        for index in cards.indices{
            let button = cards[index]
            let card = game.cards[index]
            if card.isMatched{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
            }else if card.isFaceUp{
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for:UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.7319397827, blue: 0.4253600333, alpha: 1)
            }
        }
    }

}

