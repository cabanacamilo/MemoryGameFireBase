//
//  ViewPasswordController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 1/28/19.
//  Copyright © 2019 Camilo Cabana. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ViewPasswordController: UIViewController {
    
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordAgain: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewSettingsController = storyboard.instantiateViewController(withIdentifier: "ViewSettingsController") as! ViewSettingsController
        self.present(GoToHome,animated: true, completion: nil)
    }

//    @IBAction func submitButton(_ sender: UIButton)
//    {
//        let userID = Auth.auth().currentUser?.uid
//        Database.database().reference().child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//
//            let value = snapshot.value as? NSDictionary
//            let user = User()
//
//            user.password = value?["Photo user"] as? String ?? ""
//
//            if user.password == self.currentPassword.text
//            {
//                if self.newPassword.text == self.newPasswordAgain.text
//                {
//                    let userID = Auth.auth().currentUser?.uid
//                    Database.database().reference().child("Users").child(userID!).updateChildValues(["Password": self.newPassword.text])
//                }
//            }
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
