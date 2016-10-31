//
//  Posts.swift
//  MetaCogApp
//
//  Created by Buka Cakrawala on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

struct Posts {
    let key: String
    let title: String
    let content: String
    let userName: String!
    let timeStamp: String
    let databaseReference: FIRDatabaseReference?
    
    init(key: String = "", title: String, content: String, userName: String, timeStamp: String) {
        self.key = key
        self.title = title
        self.content = content
        self.userName = userName
        self.timeStamp = timeStamp
        self.databaseReference = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        databaseReference = snapshot.ref
        
        let i = snapshot.value as! NSDictionary
        print("\n\n\n")
        print(i)
        print("---------------")
        print("\n\n\n")
        
        if let titleContent = i["title"] as? String {
            title = titleContent
        } else {
            title = ""
        }

        
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
        
        if let updateTime = i["timeStamp"] as? String {
            timeStamp = updateTime
        } else {
            timeStamp = ""
        }
        
    }
    
    func toAnyObject() -> NSDictionary {
        return ["title": title, "content": content, "userName": userName, "timeStamp": timeStamp]
    }
}
