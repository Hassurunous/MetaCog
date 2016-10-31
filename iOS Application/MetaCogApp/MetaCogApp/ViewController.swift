//
//  ViewController.swift
//  MetaCogApp
//
//  Created by Guti on 10/20/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func logInUser(_ sender: AnyObject) {
        
        let loginAlert = UIAlertController(title: "Log in", message: "Please log in", preferredStyle: .alert)
        
        loginAlert.addTextField { (emailField) in
            emailField.placeholder = "email"
        }
        
        loginAlert.addTextField { (passwordField) in
            passwordField.isSecureTextEntry = true
            passwordField.placeholder = "password"
            
        }
        
        loginAlert.addAction(UIAlertAction(title: "log in", style: .default, handler: { (action) in
            let email = loginAlert.textFields?.first
            let password = loginAlert.textFields?.last
            
            FIRAuth.auth()?.signIn(withEmail: (email?.text)!, password: (password?.text)!, completion: { (user, error) in
                
                if let error = error {
                    print("\n\n\n")
                    print(error.localizedDescription)
                    print("\n\n\n")
                    return
                } else {
                    self.performSegue(withIdentifier: "loggedIn", sender: nil)
                }
                
                
                
            })
        })
        )
        
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        
        self.present(loginAlert, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func signUpUser(_ sender: AnyObject) {
        
        let signUpAlert = UIAlertController(title: "Sign up", message: "Please sign up", preferredStyle: .alert)
        
        signUpAlert.addTextField { (emailField) in
            emailField.placeholder = "email"
        }
        
        signUpAlert.addTextField { (passwordField) in
            passwordField.isSecureTextEntry = true
            passwordField.placeholder = "password"
        }
        
        
        signUpAlert.addAction(UIAlertAction(title: "sign up", style: .default, handler: { (action) in
            let email = signUpAlert.textFields?.first
            let password = signUpAlert.textFields?.last
            
            FIRAuth.auth()?.createUser(withEmail: (email?.text)!, password: (password?.text)!, completion: { (user, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    self.performSegue(withIdentifier: "loggedIn", sender: nil)

                    
                    
                }
                
            })
        }))
        
        
        // MARK: - TODO  How to show sign up action before cancel
        signUpAlert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        
        
        
        self.present(signUpAlert, animated: true, completion: nil)
        
    }
   
    
    func signedIn(_ user: FIRUser?) {
        
        
        
    }
    
    

}

