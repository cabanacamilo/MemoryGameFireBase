//
//  ViewMenuController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/3/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewMenuController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readUser()
    }
    
    func readUser()
    {
        let userID = Auth.auth().currentUser?.uid
        Database.database().reference().child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
            let username = value?["User Name"] as? String ?? ""
            
            self.nameLabel.text = "Hello \(username)"
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    @IBAction func signOutButton(_ sender: UIButton)
    {
        do
        {
            try Auth.auth().signOut()
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let GoToHome: ViewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(GoToHome,animated: true, completion: nil)
        }
        catch
        {
            print("There is a problem logging out")
        }
    }
    
    @IBAction func playGameButton(_ sender: UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewPlayGameController = storyboard.instantiateViewController(withIdentifier: "ViewPlayGameController") as! ViewPlayGameController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    @IBAction func scoresButton(_ sender: UIButton)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewScoresController = storyboard.instantiateViewController(withIdentifier: "ViewScoresController") as! ViewScoresController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
