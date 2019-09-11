//
//  EndGamePopupViewController.swift
//  MatchEm
//
//  Created by Yuren Wang on 9/10/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import UIKit

class EndGamePopupViewController: UIViewController {
    
    var message:String?
    
    @IBOutlet weak var gameEndMessage: UILabel!
    @IBOutlet weak var newRecordMessage: UILabel!
    
    @IBAction func restartGame(_ sender: Any) {
        
        self.removeAnimate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameEndMessage.text = GameViewController.endGameMessage
        self.newRecordMessage.text = GameViewController.newRecordMessage

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)

        self.showAnimate()
    }
    
    // removed prepare for segue function as we will be using static user
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "restartID" {
//            let gameViewVC = segue.destination as! GameViewController
////            gameViewVC.user = self.user
//        } else if segue.identifier == "homeID" {
//            let startupViewVC = segue.destination as! StartupViewController
//            startupViewVC.user = GameViewController.user
//        }
//    }
    
    // this is an animation developed by Awseeley on Github
    func showAnimate() {
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
