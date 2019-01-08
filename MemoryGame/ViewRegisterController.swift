//
//  ViewRegisterController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/10/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ViewRegisterController: UIViewController
{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var photoUser: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {   
        super.viewDidLoad()
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(changePhoto))
        photoUser.isUserInteractionEnabled = true
        photoUser.addGestureRecognizer(imageTap)
        photoUser.layer.cornerRadius = photoUser.bounds.height / 2
        photoUser.clipsToBounds = true

        photoButton.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    @IBAction func changePhoto(_ sender: UIButton)
    {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func goToLogIn(_ sender: UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    @IBAction func subtmitRegister(_ sender: UIButton)
    {
        var title = ""
        var message = ""
        if let email = emailTextField.text, let pass = passwordTextField.text, let userName = userNameTextField.text
        {
            Auth.auth().createUser(withEmail: email, password: pass)
            { (user, error) in
                if user != nil
                {
                    guard let uid = Auth.auth().currentUser?.uid else {return}
                    let storageRef = Storage.storage().reference().child("User Photo/\(uid)")
                    
                    guard let imageData = self.photoUser.image!.jpegData(compressionQuality: 0.75) else{return}
                    
                    storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                        if error != nil{
                            return
                        }
                        storageRef.downloadURL { (url, error) in
                            guard let downloadURL = url else {
                                return
                            }
                            let userID = Auth.auth().currentUser?.uid
                            Database.database().reference().child("Users").child(userID!).setValue(["User Name": userName, "Email":email, "Password": pass, "Photo user": downloadURL.absoluteString])
                            
                            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let GoToHome: ViewMenuController = storyboard.instantiateViewController(withIdentifier: "ViewMenuController") as! ViewMenuController
                            self.present(GoToHome,animated: true, completion: nil)
                        }
                    }
                }
                else
                {
                    title = "Try Again"
                    message = "Password or Email no available"
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension ViewRegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        
        guard let pickedImage = info[.originalImage] as? UIImage else {
            print("Expected a dictionary containing an image, but was provided the following: \(info)")
            
            return
        }
        
        photoUser.image = pickedImage
        
        dismiss(animated: true, completion: nil)
    }
}



