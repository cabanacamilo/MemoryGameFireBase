//
//  ViewReportController.swift
//  MemoryGame
//
//  Created by Camilo Cabana on 1/28/19.
//  Copyright © 2019 Camilo Cabana. All rights reserved.
//

import UIKit

class ViewReportController: UIViewController {

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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
