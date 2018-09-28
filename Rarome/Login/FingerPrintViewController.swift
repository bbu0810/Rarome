//
//  FingerPrintViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/10/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import LocalAuthentication
class FingerPrintViewController: UIViewController{
    var sFromWhere = String()
    
    var sName = String()
    var sEmail = String()
    var sImagePath = String()
    var sUserId = String()
    var sUserType = String()
    var sRunging_year = String()
    var sSchoolID = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUser()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sUserType == "school_admin"{
            var DestinationViewController = segue.destination as! AdminDashboardViewController
            DestinationViewController.sName = self.sName
            DestinationViewController.sEmail = self.sEmail
            DestinationViewController.sImagePath = self.sImagePath
            DestinationViewController.sUserId = self.sUserId
            DestinationViewController.sUserType = self.sUserType
            DestinationViewController.sRunging_year = self.sRunging_year
            DestinationViewController.sSchoolID = self.sSchoolID
        } else if sUserType == "teacher" {
            
        } else if sUserType == "bu"{
            //            var DestinationViewController = segue.destination as! MainHomeViewController
            //            DestinationViewController.sUserId = self.sUserId
            //            DestinationViewController.sUserType = self.sUserType
            //            DestinationViewController.sSchoolID = self.sSchoolID
            //            DestinationViewController.sRunging_year = self.sRunging_year
        }
    }

    @IBAction func onClick_btnUsePasscode(_ sender: UIButton, forEvent event: UIEvent) {
        GlobalConst.glb_bUseFingerPrint = false
    }
    
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        if self.sFromWhere == "FromLogin"{
                            let bUsedFingerPrint = true
                            let permissionState = UserDefaults.standard
                            permissionState.set(bUsedFingerPrint, forKey: "bUsedFingerPrint")
                            self.sUserType = permissionState.string(forKey: "sUserType")!
                            if self.sUserType == "school_admin"{
                                self.performSegue(withIdentifier: "gotoAdminDashBoard", sender: self)
                            } else if self.sUserType == "teacher"{
                                self.performSegue(withIdentifier: "gotoTeacherDashBoard", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "gotoMapViewController", sender: self)
                            }
                        } else {
                            let permission = UserDefaults.standard
                            self.sName = permission.string(forKey: "sName")!
                            self.sEmail = permission.string(forKey: "sEmail")!
                            self.sImagePath = permission.string(forKey: "sImagePath")!
                            self.sUserId = permission.string(forKey: "sUserId")!
                            self.sUserType = permission.string(forKey: "sUserType")!
                            self.sSchoolID = permission.string(forKey: "sSchoolID")!
                            self.sRunging_year = permission.string(forKey: "sRunging_year")!
                            GlobalConst.glb_sUserId = self.sUserId
                            GlobalConst.glb_sSchoolID = self.sSchoolID
                            GlobalConst.glb_sUserType = self.sUserType
                            GlobalConst.glb_sRunning_year = self.sRunging_year
                            GlobalConst.glb_studentImg_path = self.sImagePath
                            if self.sUserType == "school_admin"{
                                self.performSegue(withIdentifier: "gotoAdminDashBoard", sender: self)
                            } else if self.sUserType == "teacher"{
                                self.performSegue(withIdentifier: "gotoTeacherDashBoard", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "gotoMapViewController", sender: self)
                            }
                        }

                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "Sorry!", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    


}
