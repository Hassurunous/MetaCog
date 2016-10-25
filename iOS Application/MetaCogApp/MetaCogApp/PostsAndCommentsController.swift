//
//  PostsAndCommentsController.swift
//  MetaCogApp
//
//  Created by Buka Cakrawala on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit

class PostAndCommentsController: UITableViewController {
    
    var username: String?
    var timeString: String?
    var userImage: String?
    var content: String?
    var postTitle: String?
    
    
    
    
    
    override func viewDidLoad() {
        //
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postDetailCell", for: indexPath) as! CommentCell
        
        cell.usernameLabel?.text = username
        cell.timePostLabel?.text = timeString
        cell.userImage?.image = UIImage(named: "mac_os")
        cell.postTextView.text = content
        cell.postTitle?.text = postTitle
        
        return cell
    }
}
