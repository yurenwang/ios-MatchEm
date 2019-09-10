//
//  CardModel.swift
//  MatchEm
//
//  Created by Yuren Wang on 7/3/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import Foundation

class CardModel {

    func getCards() -> [Card] {
        
        var generatedCards = [Card]()
        var generatedNumbers = [Int]()
        
        // generate 8 pairs of cards randomly
        // make sure no duplicate pairs
        while generatedNumbers.count < 8 {
            let randomNumber = arc4random_uniform(13) + 1
            
            if !generatedNumbers.contains(Int(randomNumber)) {
                
//                print(randomNumber)
                
                let cardOne = Card()
                let cardTwo = Card()
                
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCards.append(cardOne)
                generatedCards.append(cardTwo)
                
                generatedNumbers.append(Int(randomNumber))
            }
        }
        
        // Randomize the array
        for i in 0...generatedCards.count-1 {
            
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCards.count)))
            
            let tempCard = generatedCards[i]
            generatedCards[i] = generatedCards[randomNumber]
            generatedCards[randomNumber] = tempCard
        }
        
        return generatedCards
    }
}
