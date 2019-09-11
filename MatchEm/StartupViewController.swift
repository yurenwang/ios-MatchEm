//
//  StartupViewController.swift
//  MatchEm
//
//  Created by Yuren Wang on 9/9/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import UIKit

class StartupViewController: UIViewController {

    @IBOutlet weak var startupNameFieldLabel: UILabel!
    @IBOutlet weak var personalRecordFieldLabel: UILabel!
    
    static var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SoundManager.playSound(.background, .mp3)

        self.startupNameFieldLabel.text = "Hi \(StartupViewController.user!.name!)."
        self.personalRecordFieldLabel.text = "Personal Record: \(StartupViewController.user!.personalRecord ?? 0)"
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
