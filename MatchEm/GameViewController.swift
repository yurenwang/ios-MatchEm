//
//  ViewController.swift
//  MatchEm
//
//  Created by Yuren Wang on 7/3/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var timer:Timer?
    var milliseconds:Float = 30 * 1000
    
    var firstFlippedCardIndex:IndexPath?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cardArray = model.getCards()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        // create timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        SoundManager.playSound(.shuffle)
    }
    
    @objc func timerElapsed() {
        
        milliseconds -= 1
        
        // convert to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        timerLabel.text = "Time Remaining: \(seconds)"
        
        // when the timer has reached 0
        if milliseconds <= 0 {
            
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            // check if there are any cards unmatched
            checkGameEnded()
        }
        
    }

    // MARK: - UICollectionView Protocal Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Get an CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        // Set that card for the cell
        cell.setCard(card)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // check if there's any time left
        if milliseconds <= 0 {
            return
        }
        
        // get the cell that user is clicking
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        // get the card that user is clicking
        let card = cardArray[indexPath.row]
        
        if card.isMatched == false && card.isFlipped == false {
            
            SoundManager.playSound(.flip)
            
            cell.flip()
            card.isFlipped = true
            
            // check if its the first card
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
                
            }
            else {
                
                // perform the matching logic
                checkForMatches(indexPath)
                
            }
            
        }
        
    }
    
    // MARK: - Game Logic Methods
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        
        // get the two cells to compare
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // get the two cards to compare
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        // compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            // it's a match
            SoundManager.playSound(.match)
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            // check if game is won
            checkGameEnded()
            
        }
        else {
            
            // it's not a match
            SoundManager.playSound(.nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        
        // tell the collectionView to reload the cell of the first card if it is nil
        // to avoid the problem that caused by removed cell after scrolling away making flipBack()
        // function not being called
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        firstFlippedCardIndex = nil
        
    }
    
    func checkGameEnded() {
        
        // determine if there are any cards unmatched
        var allMatched = true
        
        for card in cardArray {
            
            if card.isMatched == false {
                allMatched = false
                break
            }
        }
        
        var title = ""
        var message = ""
        
        // if not, then user has won, stop the timer
        if allMatched {
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
            title = "Congratulations!"
            message = "You've won"
            
        }
        else {
            
            // if there are unmatched cards, check if there's any time left
            if milliseconds > 0 {
                return
            }
            
            title = "Game Over"
            message = "You've lost"
        }
        
        // show won/lost message
        showAlert(title, message)
        
    }
    
    func showAlert(_ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}
