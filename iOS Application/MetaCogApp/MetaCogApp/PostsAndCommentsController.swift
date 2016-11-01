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
    var dateString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight  = UITableViewAutomaticDimension
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let date = NSDate().timeIntervalSince1970
        let formatter = DateFormatter()
        
        formatter.timeStyle = .short
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postDetailCell", for: indexPath) as! CommentCell
        
        cell.usernameLabel?.text = username
        cell.timePostLabel?.text = timeString
        
        cell.textview.text = content
        cell.titlePostLabel.text = postTitle
        cell.timePostLabel?.text = ""
        
        return cell
    }
}
