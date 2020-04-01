//
//  MatchingGame.swift
//  test
//
//  Created by student on 2020/3/30.
//  Copyright © 2020年 student. All rights reserved.
//

import Foundation

class MatchingGame{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                    cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard{
                if matchIndex == index{
                    cards[index].isFaceUp = false
                }
                else if matchIndex != index{
                    if cards[index].identifier == cards[matchIndex].identifier{
                        cards[index].isMatched = true
                        cards[matchIndex].isMatched = true
                    }
                    cards[index].isFaceUp = true
                }
            }else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func allBack(at index: Int){
        cards[index].isFaceUp = false
    }
    
    init(numberOfPairsOfCards: Int){
        var liveId = [Int]()
        for _ in 1...numberOfPairsOfCards{
            liveId.append(0)
        }
        for i in 1...numberOfPairsOfCards{
            var id = arc4random_uniform(UInt32(numberOfPairsOfCards))
            var key = 0
            while key<2 {
                print(key)
                print(liveId[Int(id)])
                print(Int(id))
                if liveId[Int(id)] < 2{
                    liveId[Int(id)] += 1
                    key += 1
                    let card = Card(at:Int(id))
                    cards += [card]
                }
                id = arc4random_uniform(UInt32(numberOfPairsOfCards))
            }
        }
    }
    
    
}
