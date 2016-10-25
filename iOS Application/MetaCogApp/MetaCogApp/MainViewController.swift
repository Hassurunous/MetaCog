//
//  MainViewController.swift
//  MetaCogApp
//
//  Created by Guti on 10/20/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
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
        let currentUser = FIRAuth.auth()?.currentUser?.email
        let userAlert = UIAlertController(title: "Post", message: "Enter your title and assumption", preferredStyle: .alert)
        userAlert.addTextField { (titleTextField) in
            titleTextField.placeholder = "Enter your title"
        }
        userAlert.addTextField { (contentTextField) in
            contentTextField.placeholder = "Enter your assumption"
        }
        userAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            let titleContentText = userAlert.textFields?.first?.text!
            let contentText = userAlert.textFields?.first?.text!
            let post = Posts(title: titleContentText!, content: contentText!, userName: currentUser!)
            let titleRef = self.databaseReference.child((titleContentText?.lowercased())!)
            let contentRef = self.databaseReference.child((contentText?.lowercased())!)
            
            
            titleRef.setValue(post.toAnyObject())
            contentRef.setValue(post.toAnyObject())
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
            if identifier == "postsAndCommentsSegue" {
                print("users want to add some comments")
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
