//
//  AddPostViewController.swift
//  MetaCogApp
//
//  Created by Buka Cakrawala on 10/23/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddPostViewController: UIViewController {
    
    let dbRef = FIRDatabase.database().reference(withPath: "post-items")

    @IBAction func saveButton(_ sender: AnyObject) {
    }
   
    @IBAction func cancelButton(_ sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
