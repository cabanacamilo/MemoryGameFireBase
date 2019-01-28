//
//  ViewController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/3/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController
{
    var isSigIn = true
    
    @IBOutlet weak var logingLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logingButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil
        {
            goToMenu()
        }
    }
    
    @IBAction func sigInButtonTouch(_ sender: UIButton)
    {
        var title = ""
        var message = ""
        if let email = emailTextField.text, let pass = passwordTextField.text
        {
            Auth.auth().signIn(withEmail: email, password: pass)
            { (user, error) in
                if user != nil
                {
                    self.goToMenu()
                }
                else
                {
                    title = "Try Again"
                    message = "Incorrect Password or Email"
                }
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(alertAction)
                    
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func goToRegister(_ sender: UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewRegisterController = storyboard.instantiateViewController(withIdentifier: "ViewRegisterController") as! ViewRegisterController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    func goToMenu()
    {
    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let GoToHome: ViewMenuController = storyboard.instantiateViewController(withIdentifier: "ViewMenuController") as! ViewMenuController
    self.present(GoToHome,animated: true, completion: nil)
    }
}


