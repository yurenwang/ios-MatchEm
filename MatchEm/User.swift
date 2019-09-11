//
//  User.swift
//  MatchEm
//
//  Created by Yuren Wang on 9/9/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import UIKit
import os.log

class User: NSObject, NSCoding {
    
    // MARK: Properties
    struct PropertyKey {
        
        static let name = "name"
        static let pr = "pr"
    }
    
    var name: String?
    var personalRecord: Double?
    
    // initialization
    init(name: String, personalRecord: Double) {
        self.name = name
        self.personalRecord = personalRecord
    }
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("user")
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(personalRecord, forKey: PropertyKey.pr)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // the initializer should fail if we cannot decode a name
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            
            os_log("No user is saved")
            return nil
        }
        
        let pr = aDecoder.decodeObject(forKey: PropertyKey.pr) as? Double ?? 0.0
        
        self.init(name: name, personalRecord: pr)
    }
}
