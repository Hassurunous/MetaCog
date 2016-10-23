//
//  MainViewController.swift
//  MetaCogApp
//
//  Created by Guti on 10/20/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UITableViewController {
    //MainViewController Class is a UITableViewController sub-class which will later dispaly the users posts.
    
    @IBAction func unwindToMainViewController(_ segue: UIStoryboardSegue) {
        
    }
    
        

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "postsAndCommentsSegue" {
                print("users want to add some comments")
            } else if identifier == "addPostsSegue"{
                print("users want to add some posts")
            }else if identifier == "Cancel" {
                print("perform unwind segue Cancel")
            } else if identifier == "Save" {
                print("perform unwind segue Save")
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        return cell
    }

}
