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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if let user = user {
                print("welcome \(user.email)")
                self.startObservingDB()
            } else {
                print("no user id")
            }
        })
    }

    
        
    @IBAction func addButton(_ sender: AnyObject) {
        
        let userName = FIRAuth.auth()?.currentUser?.email
        
        let userAlert = UIAlertController(title: "New Post", message: "Enter you post here!", preferredStyle: .alert)
        
        userAlert.addTextField { (titleTextField) in
            titleTextField.placeholder = "Enter your title."
        }
        
        userAlert.addTextField { (contentTextField) in
            contentTextField.placeholder = "Enter your content."
        }
        
        userAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            let titleText = userAlert.textFields?.first
            let contentText = userAlert.textFields?.last
            
            let post = Posts(title: (titleText?.text)!, content: (contentText?.text)!, userName: userName!)
            
            let postReference = self.databaseReference.child((titleText?.text?.lowercased())!)
            postReference.setValue(post.toAnyObject())
            
        }))
        
        self.present(userAlert, animated: true, completion: nil)
        
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

    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "commentSegue" {
                print("users want to add some comments")
                if let indexPath = tableView.indexPathForSelectedRow {
                    let destController = segue.destination as! PostAndCommentsController
                    
                    destController.username = posts[indexPath.row].userName
                    destController.content = posts[indexPath.row].content
                    destController.postTitle = posts[indexPath.row].title
                    

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
