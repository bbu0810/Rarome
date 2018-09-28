//
//  MainHomeViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/22/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class MainHomeViewController: UIViewController {
    
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! GoogleMapViewController
        DestinationViewController.sUserId = self.sUserId
        DestinationViewController.sUserType = self.sUserType
        DestinationViewController.sSchoolID = self.sSchoolID
        DestinationViewController.sRunging_year = self.sRunging_year
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
