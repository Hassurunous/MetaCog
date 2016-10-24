//
//  Posts.swift
//  MetaCogApp
//
//  Created by Buka Cakrawala on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Posts {
    let title: String
    let content: String
    let userName: String
    let databaseReference: FIRDatabaseReference?
    
    init(title: String, content: String, userName: String) {
        self.title = title
        self.content = content
        self.userName = userName
        self.databaseReference = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        title = snapshot.key
        databaseReference = snapshot.ref
        
        let i = snapshot.value as! NSDictionary
        
        if let postContent = i["content"] as? String {
            content = postContent
        } else {
            content = ""
        }
        
        if let postUser = i["userName"] as? String {
            userName = postUser
        } else {
            userName = ""
        }
        
    }
    
    func toAnyObject() -> NSDictionary {
        return ["content": content, "userName": userName]
    }
}
