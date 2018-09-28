//
//  AdminDashboardViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/24/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AdminDashboardViewController: UIViewController {
    
    var sName: String!
    var sEmail: String!
    var sImagePath: String!
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!

    
    var iTarget: Int!
    let iGotoProfileViewController: Int = 1
    let iGotoMessageBoxViewController: Int = 2
    let iGotoFeeReportsViewController: Int = 3
    let iGotoStudentInfomationViewController: Int = 4
    let iGotoEmployeeInformationViewController: Int = 5
    let iGotoAttendanceViewController: Int = 6
    let iGotoMessagesViewController: Int = 7
    let iGotoBestPerformanceViewController: Int = 8
    

    override func viewDidLoad() {
        super.viewDidLoad()
        iTarget = -1
        appComponentsInNavigationBar()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch iTarget{
        case iGotoProfileViewController:
            let DestinationViewController = segue.destination as! ProfileViewController
            DestinationViewController.sName = self.sName
            DestinationViewController.sEmail = self.sEmail
            DestinationViewController.sImagePath = self.sImagePath
            DestinationViewController.sUserId = self.sUserId
            DestinationViewController.sUserType = self.sUserType
            DestinationViewController.sRunging_year = self.sRunging_year
            DestinationViewController.sSchoolID = self.sSchoolID
            break
        case iGotoMessageBoxViewController:
            break
        case iGotoFeeReportsViewController:
            let DestinationViewController = segue.destination as! ParentViewController
            DestinationViewController.sUserId = self.sUserId
            DestinationViewController.sUserType = self.sUserType
            DestinationViewController.sRunging_year = self.sRunging_year
            DestinationViewController.sSchoolID = self.sSchoolID
        case .none:
            break
        case .some(_):
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func appComponentsInNavigationBar(){
        if let navigationBar = self.navigationController?.navigationBar{
//            let nameFrame = CGRect(x: 100, y: 0, width: navigationBar.frame.width/3, height: navigationBar.frame.height)
//            let nameLabel = UILabel(frame: nameFrame)
//            nameLabel.text = sName
//            navigationBar.addSubview(nameLabel)

            let btn_profile = UIButton(type: UIButtonType.custom)
            let btn_messages = UIButton(type: UIButtonType.custom)
            btn_profile.setImage(UIImage(named: "ic_person"), for: UIControlState.normal)
            btn_messages.setImage(UIImage(named: "ic_notifications"), for: UIControlState.normal)
            btn_profile.addTarget(self, action: #selector(AdminDashboardViewController.onClick_profile), for: UIControlEvents.touchDown)
            btn_messages.addTarget(self, action: #selector(AdminDashboardViewController.onClick_message), for: UIControlEvents.touchDown)
            btn_profile.frame=CGRect(x: 30, y: 0, width: 30,  height: navigationBar.frame.height)
            btn_messages.frame=CGRect(x: 0, y: 0, width: 30,  height: navigationBar.frame.height)
            let barProfile = UIBarButtonItem(customView: btn_profile)
            let barMessage = UIBarButtonItem(customView: btn_messages)
            self.navigationItem.rightBarButtonItems = [barProfile, barMessage]
        }
    }
    
    func deleteConponemetsInNavigation(){
        if let navigationBar = self.navigationController?.navigationBar{
            var subview: [UIView] = navigationBar.subviews
            navigationBar.willRemoveSubview(subview[1])
            navigationBar.willRemoveSubview(subview[2])
            navigationBar.willRemoveSubview(subview[3])
            navigationBar.willRemoveSubview(subview[4])
        }
    }
    func onClick_profile(){
        self.iTarget = 1
        self.performSegue(withIdentifier: "gotoProfileViewController", sender: self)
    }
    func onClick_message(){
        self.iTarget = 2
        self.performSegue(withIdentifier: "gotoMessgeBoxViewController", sender: self)
    }
    
    @IBAction func onClick_feeReports(_ sender: UIButton, forEvent event: UIEvent) {
        self.iTarget = 3
        
    }
    
    @IBAction func onClick_studentInformation(_ sender: UIButton, forEvent event: UIEvent) {
        self.iTarget = 4
        
    }
    
    @IBAction func onClick_employeeInformation(_ sender: UIButton, forEvent event: UIEvent) {
        self.iTarget = 5
        
    }
    
    @IBAction func onClick_attendand(_ sender: UIButton, forEvent event: UIEvent) {
        self.iTarget = 6
        
    }
    
    @IBAction func onClick_messages(_ sender: UIButton, forEvent event: UIEvent) {
        self.iTarget = 7
    }
    
    @IBAction func onClick_bestPerformance(_ sender: UIButton, forEvent event: UIEvent) {
        self.iTarget = 8
    }
    
    
    
    
}
