//
//  User.swift
//  MatchEm
//
//  Created by Yuren Wang on 9/9/19.
//  Copyright © 2019 Frederick Wang. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    
    // MARK: Properties
    struct PropertyKey {
        
        static let name = "name"
        static let pr = "pr"
    }
    
    var name: String?
    var personalRecord: Float?
    
    // initialization
    init(name: String, personalRecord: Float) {
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
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let pr = aDecoder.decodeFloat(forKey: PropertyKey.pr)
        
        if name != nil {
            
            self.init(name: name!, personalRecord: pr)
        }
        else {
            
            self.init(name: "", personalRecord: 0)
        }
    }
}
