//
//  SavedUserViewController.swift
//  MatchEm
//
//  Created by Yuren Wang on 9/11/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import UIKit

class SavedUserViewController: UIViewController {

    @IBOutlet weak var userNameFieldLabel: UILabel!
    
    @IBAction func createNewUser(_ sender: Any) {
        
        self.removeAnimate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNameFieldLabel.text = UserPageViewController.savedUser!.name! + ", welcome back!"
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        self.showAnimate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        self.user?.name = nameField.text
//        let startupVC = segue.destination as! StartupViewController
        StartupViewController.user = UserPageViewController.savedUser
    }
    
    
    // this is an animation developed by Awseeley on Github
    func showAnimate() {
        
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 1, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate() {
        
        UIView.animate(withDuration: 0.4, animations: {
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
