//
//  AdminDashboardViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/24/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AdminDashboardViewController: UIViewController {
    
    @IBOutlet weak var img_feeReports: UIImageView!
    @IBOutlet weak var img_studentInformation: UIImageView!
    @IBOutlet weak var img_employeeInformation: UIImageView!
    @IBOutlet weak var img_attandence: UIImageView!
    @IBOutlet weak var img_message: UIImageView!
    @IBOutlet weak var img_bestInformation: UIImageView!
    
    let lbl_userName = UILabel()
    
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
        addActionsToComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let sUsernsme = UserDefaults.standard.string(forKey: "sName")
        self.navigationItem.setHidesBackButton(true, animated:true)
        lbl_userName.text = sUsernsme
        lbl_userName.textColor = UIColor.white
        let leftItem = UIBarButtonItem(customView: lbl_userName)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        self.lbl_userName.removeFromSuperview()
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
    }

    
    func appComponentsInNavigationBar(){
        if let navigationBar = self.navigationController?.navigationBar{

            let btn_profile = UIButton(type: UIButtonType.custom)
            let btn_messages = UIButton(type: UIButtonType.custom)
            let btn_logout = UIButton(type: UIButtonType.custom)
            btn_profile.setImage(UIImage(named: "ic_person"), for: UIControlState.normal)
            btn_messages.setImage(UIImage(named: "ic_notifications"), for: UIControlState.normal)
            btn_logout.setImage(UIImage(named: "ic_logout"), for: UIControlState.normal)
            btn_profile.addTarget(self, action: #selector(AdminDashboardViewController.onClick_profile), for: UIControlEvents.touchDown)
            btn_messages.addTarget(self, action: #selector(AdminDashboardViewController.onClick_message), for: UIControlEvents.touchDown)
            btn_logout.addTarget(self, action: #selector(AdminDashboardViewController.onClick_logout), for: UIControlEvents.touchDown)
            btn_profile.frame=CGRect(x: 0, y: 0, width: 30,  height: navigationBar.frame.height)
            btn_messages.frame=CGRect(x: 0, y: 0, width: 30,  height: navigationBar.frame.height)
            btn_logout.frame=CGRect(x: 0, y: 0, width: 30,  height: navigationBar.frame.height)
            let barProfile = UIBarButtonItem(customView: btn_profile)
            let barMessage = UIBarButtonItem(customView: btn_messages)
            let barLogout = UIBarButtonItem(customView: btn_logout)
            self.navigationItem.rightBarButtonItems = [barLogout, barProfile, barMessage]
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
    
    func onClick_logout(){

    }
    
    @objc func onClick_feeReports() {
        self.iTarget = 3
        self.performSegue(withIdentifier: "gotoFeeReports", sender: self)
    }
    
    @objc func onClick_studentInformation() {
        self.iTarget = 4
        self.performSegue(withIdentifier: "gotoStudentsInfo", sender: self)
    }

    @objc func onClick_employeeInformation() {
        self.iTarget = 5
        self.performSegue(withIdentifier: "gotoEmployeeInformation", sender: self)
    }
    
    @objc func onClick_attendand() {
        self.iTarget = 6
        self.performSegue(withIdentifier: "gotoAttendance", sender: self)
    }
    
    @objc func onClick_messages() {
        self.iTarget = 7
        self.performSegue(withIdentifier: "gotoMessage", sender: self)
    }
    
    @objc func onClick_bestPerformance() {
        self.iTarget = 8
    }
    
    func addActionsToComponents(){
        let feeTap = UITapGestureRecognizer(target: self, action: Selector("onClick_feeReports"))
        img_feeReports.isUserInteractionEnabled = true
        img_feeReports.addGestureRecognizer(feeTap)
        let studenTap = UITapGestureRecognizer(target: self, action: Selector("onClick_studentInformation"))
        img_studentInformation.isUserInteractionEnabled = true
        img_studentInformation.addGestureRecognizer(studenTap)
        let employeeTap = UITapGestureRecognizer(target: self, action: Selector("onClick_employeeInformation"))
        img_employeeInformation.isUserInteractionEnabled = true
        img_employeeInformation.addGestureRecognizer(employeeTap)
        let sttandenceTap = UITapGestureRecognizer(target: self, action: Selector("onClick_attendand"))
        img_attandence.isUserInteractionEnabled = true
        img_attandence.addGestureRecognizer(sttandenceTap)
        let messageTap = UITapGestureRecognizer(target: self, action: Selector("onClick_messages"))
        img_message.isUserInteractionEnabled = true
        img_message.addGestureRecognizer(messageTap)
        let bestTap = UITapGestureRecognizer(target: self, action: Selector("onClick_bestPerformance"))
        img_bestInformation.isUserInteractionEnabled = true
        img_bestInformation.addGestureRecognizer(bestTap)
    }
}
