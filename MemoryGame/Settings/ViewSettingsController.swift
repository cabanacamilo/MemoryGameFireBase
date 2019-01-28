//
//  ViewSettingsController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 1/26/19.
//  Copyright © 2019 Camilo Cabana. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewSettingsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var settingsList = ["Password", "Language", "Report a Problem"]
    var segueIdentifiers = ["password", "language", "report"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func menuButton(_ sender: UIBarButtonItem)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewMenuController = storyboard.instantiateViewController(withIdentifier: "ViewMenuController") as! ViewMenuController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return settingsList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellUser") as! settingsCell
            
            let userID = Auth.auth().currentUser?.uid
            Database.database().reference().child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                
                let value = snapshot.value as? NSDictionary
                let user = User()
                user.user = value?["User Name"] as? String ?? ""
                user.photoUser = value?["Photo user"] as? String ?? ""
                
                cell.currentUser.text = user.user
                
                cell.currentUserPhoto.image = UIImage(named: "user")
                cell.currentUserPhoto.layer.cornerRadius = cell.currentUserPhoto.bounds.height / 2
                cell.currentUserPhoto.clipsToBounds = true
                cell.currentUserPhoto.loadImageUsingCache(urlString: user.photoUser)
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell") as! settingsCell
            
            cell.settingsLabel.text = settingsList[indexPath.row]
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 1
        {
            performSegue(withIdentifier: segueIdentifiers[indexPath.row], sender: self)
        }
    }

}

