//
//  UserPageViewController.swift
//  MatchEm
//
//  Created by Yuren Wang on 9/9/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import UIKit

class UserPageViewController: UIViewController {
    
    @IBOutlet weak var nameFieldLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    var user: User?
    static var savedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SoundManager.playSound(.background, .mp3)
        
        let savedUser = loadUser()
        
        if savedUser != nil {
            UserPageViewController.savedUser = savedUser!
            showPopup()
        }

        self.user = User(name: "", personalRecord: 0)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.user?.name = nameField.text
//        let startupVC = segue.destination as! StartupViewController
        StartupViewController.user = self.user
    }
    
    // check if the name entered is valid (containing at least 2 characters)
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if let name = nameField.text, name.count >= 2 {
            return true
        }
        return false
    }
    
    // try to load user from saved local files
    private func loadUser() -> User? {
        
        return NSKeyedUnarchiver.unarchiveObject(withFile: User.ArchiveURL.path) as? User
    }
    
    // show popup with saved user info
    func showPopup() {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbSavedUserViewID") as! SavedUserViewController
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
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
