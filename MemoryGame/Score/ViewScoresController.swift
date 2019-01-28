//
//  ViewScoresController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 11/3/18.
//  Copyright © 2018 Camilo Cabana. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewScoresController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var userList = [User]()
    var searchUser = [User]()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readAllUsers()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewMenuController = storyboard.instantiateViewController(withIdentifier: "ViewMenuController") as! ViewMenuController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    @IBAction func playGameButton(_ sender: UIBarButtonItem)
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let GoToHome: ViewPlayGameController = storyboard.instantiateViewController(withIdentifier: "ViewPlayGameController") as! ViewPlayGameController
        self.present(GoToHome,animated: true, completion: nil)
    }
    
    func readAllUsers()
    {
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            // Get user value
            
            let value = snapshot.value as? NSDictionary
            let user = User()
            user.email = value?["Email"] as? String ?? ""
            user.user = value?["User Name"] as? String ?? ""
            user.photoUser = value?["Photo user"] as? String ?? ""
            user.flips = value?["Flip Counter"] as? Int ?? 1001
            
            self.userList.append(user)
            
            self.userList.sort(by: { (best, lowest) -> Bool in
                return best.flips < lowest.flips
            })
            
            self.searchUser = self.userList
            
            self.tableView.reloadData()
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! UserCell
        let user = searchUser[indexPath.row]
        
        cell.profileEmail.text = user.email
        
        cell.profileUser.text = user.user
        
        cell.profilePhoto.image = UIImage(named: "user")
        cell.profilePhoto.layer.cornerRadius = cell.profilePhoto.bounds.height / 2
        cell.profilePhoto.clipsToBounds = true
        cell.profilePhoto.loadImageUsingCache(urlString: user.photoUser)
        
        cell.profileScore.text = "\(user.flips)"
        if user.flips > 1000
        {
            cell.profileScore.text = ""
        }
        
        return cell
    }
    
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        guard !searchText.isEmpty else {
            searchUser = userList
            tableView.reloadData()
            return
        }
        searchUser = userList.filter({ (user) -> Bool in
            user.user.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView
{
    func loadImageUsingCache(urlString: String)
    {
        self.image = nil
        
        if let url = URL(string: urlString)
        {
            
            if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage
            {
                self.image = cachedImage
            }
            URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler:{ (data, response, error) in
                if let data = data
                {
                    DispatchQueue.main.async {
                        
                        if let downloadedImage = UIImage(data: data)
                        {
                            imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                            
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}


