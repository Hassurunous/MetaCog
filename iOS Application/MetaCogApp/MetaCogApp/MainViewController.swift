//
//  MainViewController.swift
//  MetaCogApp
//
//  Created by Guti on 10/20/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth


class MainViewController: UITableViewController {
    //MainViewController Class is a UITableViewController sub-class which will later dispaly the users posts.
    
    
    
    var databaseReference: FIRDatabaseReference!
    var posts = [Posts]()
    
    @IBAction func unwindToMainViewController(_ segue: UIStoryboardSegue) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        databaseReference = FIRDatabase.database().reference().child("post-item")
        // Do any additional setup after loading the view.
        
        startObservingDB()
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
       self.tableView.reloadData()
    }

    
    @IBAction func ProfileButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "Profile", sender: nil)
    
    }
   
        
    @IBAction func addButton(_ sender: AnyObject) {
        
        
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat  = "yyyy-MM-dd HH:mm:ss ZZZ"
        let defaultTimeZone = formatter.string(from: date as Date)
        
        
        
        let userName = FIRAuth.auth()?.currentUser?.email
        
        let userAlert = UIAlertController(title: "New Post", message: "Enter you post here!", preferredStyle: .alert)
        
        userAlert.addTextField { (titleTextField) in
            titleTextField.placeholder = "Enter your title."
        }
        
        userAlert.addTextField { (contentTextField) in
            contentTextField.placeholder = "Enter your content."
        }
        
        userAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            
            if userAlert.textFields?.first == nil || userAlert.textFields?.last == nil {
                print("\n\n\n")
                print("")
                print("\n\n\n")
                
            } else {
//                let titleText = userAlert.textFields?.first
//                let contentText = userAlert.textFields?.last
//                
//                
//                let post = Posts(title: (titleText?.text)!, content: (contentText?.text)!, userName: userName!, timeStamp: defaultTimeZone)
//                
//                let postReference = self.databaseReference.child((titleText?.text?.lowercased())!)
//                postReference.setValue(post.toAnyObject())

            }
            
        }))
        
        self.present(userAlert, animated: true, completion: nil)
        
    }
    
    func initObserver() {
        
    }
    
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startObservingDB() {
        databaseReference.observe(.value, with: { (snapshot) in
            var newPosts = [Posts]()
            
            for post in snapshot.children {
                let postObject = Posts(snapshot: post as! FIRDataSnapshot)
                newPosts.append(postObject)
            }
            
            self.posts = newPosts
            self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
    }
    
    func setupViews() {
        
    }

    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "commentSegue" {
                print("users want to add some comments")
                if let indexPath = tableView.indexPathForSelectedRow {
                    let destController = segue.destination as! PostAndCommentsController
                    
                    let date = NSDate()
                    let formatter = DateFormatter()
                    formatter.timeStyle = .short
                    
                    destController.username = posts[indexPath.row].userName
                    destController.content = posts[indexPath.row].content
                    destController.postTitle = posts[indexPath.row].title
                    destController.dateString = formatter.string(from: date as Date)
                    
                    

                }
                
            }else if identifier == "Cancel" {
                print("perform unwind segue Cancel")
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! CustomPostCell
        
        let row = indexPath.row
        let post = posts[row]
        cell.titleLabel.text = post.title
        cell.contentLabel.text = post.content
        
        return cell
    }

}
