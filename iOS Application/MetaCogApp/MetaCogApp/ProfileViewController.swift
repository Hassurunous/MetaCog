//
//  ProfileViewController.swift
//  MetaCogApp
//
//  Created by Buka Cakrawala on 10/29/16.
//  Copyright © 2016 PielDeJaguar. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let storageReference = FIRStorage.storage().reference(forURL: "gs://metacog-57941.appspot.com")
    
    var imagePicker: UIImagePickerController!
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func takePictureButton(_ sender: AnyObject) {
        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let realImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
           
            imageView.contentMode = .scaleAspectFit
            imageView.image = realImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
   
}
