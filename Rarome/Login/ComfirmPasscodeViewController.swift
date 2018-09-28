//
//  ComfirmPasscodeViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/22/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class ComfirmPasscodeViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var txtPasscode: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var sPassword: String!
    var sConfirmPassword: String!
    var bFingerprintEnable: Bool!
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    var sName: String!
    var sEmail: String!
    var sImagePath: String!
    
    var bWillFingerPrint = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtPasscode.delegate = self
        txtPasscode.addTarget(self, action: "textFieldDidChange", for: .editingChanged)
        txtPasscode.defaultTextAttributes.updateValue(25, forKey: NSKernAttributeName)
    }

    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    func textFieldDidChange(){
        if txtPasscode.text?.count == 4 {
            sConfirmPassword = txtPasscode.text
            let preferencePassword = UserDefaults.standard.string(forKey: "permission")
            if( sPassword == sConfirmPassword){
                if GlobalConst.glb_bUseFingerPrint == true {
                    var alert = UIAlertController(title: "Enable Fingerprint", message: "Use your existing fingerprints set on your device for quick login!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "no thanks", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            let permissionState = UserDefaults.standard
                            permissionState.set(self.sPassword, forKey: "permission")
                            if self.sUserType == "school_admin"{
                                self.performSegue(withIdentifier: "gotoAdminDashboardViewController", sender: self)
                            } else if self.sUserType == "teacher"{
                                self.performSegue(withIdentifier: "gotoTeacherPanel", sender: self)
                            } else {
                                self.performSegue(withIdentifier: "gotoMainHomeViewController", sender: self)
                            }
                            return
                        case .cancel:
                            return
                        case .destructive:
                            return
                        }}))
                    alert.addAction(UIAlertAction(title: "enable", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            self.bWillFingerPrint = true
                            let permissionState = UserDefaults.standard
                            permissionState.set(self.sConfirmPassword, forKey: "permission")
                            self.performSegue(withIdentifier: "gotoFingerprint", sender: self)
                            return
                        case .cancel:
                            return
                        case .destructive:
                            return
                        }}))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let permissionState = UserDefaults.standard
                    permissionState.set(self.sPassword, forKey: "permission")
                    if self.sUserType == "school_admin"{
                        self.performSegue(withIdentifier: "gotoAdminDashboardViewController", sender: self)
                    } else if self.sUserType == "teacher"{
                        self.performSegue(withIdentifier: "gotoTeacherPanel", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "gotoMainHomeViewController", sender: self)
                    }
                }
            } else if (sConfirmPassword == preferencePassword){
                let permission = UserDefaults.standard
                self.sName = permission.string(forKey: "sName")
                self.sEmail = permission.string(forKey: "sEmail")
                self.sImagePath = permission.string(forKey: "sImagePath")
                self.sUserId = permission.string(forKey: "sUserId")
                self.sUserType = permission.string(forKey: "sUserType")
                self.sSchoolID = permission.string(forKey: "sSchoolID")
                self.sRunging_year = permission.string(forKey: "sRunging_year")
                GlobalConst.glb_sUserId = self.sUserId
                GlobalConst.glb_sSchoolID = self.sSchoolID
                GlobalConst.glb_sUserType = self.sUserType
                GlobalConst.glb_sRunning_year = self.sRunging_year
                GlobalConst.glb_studentImg_path = self.sImagePath
                if self.sUserType == "school_admin"{
                    self.performSegue(withIdentifier: "gotoAdminDashboardViewController", sender: self)
                } else if self.sUserType == "teacher"{
                    self.performSegue(withIdentifier: "gotoTeacherPanel", sender: self)
                } else {
                    self.performSegue(withIdentifier: "gotoMainHomeViewController", sender: self)
                }
            }else {
                initParams()
                return
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:150), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if bWillFingerPrint == false {
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
                
            } else if sUserType == ""{
    //            var DestinationViewController = segue.destination as! MainHomeViewController
    //            DestinationViewController.sUserId = self.sUserId
    //            DestinationViewController.sUserType = self.sUserType
    //            DestinationViewController.sSchoolID = self.sSchoolID
    //            DestinationViewController.sRunging_year = self.sRunging_year
            }
        }else {
            if sUserType == "school_admin"{
                var DestinationViewController = segue.destination as! FingerPrintViewController
                DestinationViewController.sName = self.sName
                DestinationViewController.sEmail = self.sEmail
                DestinationViewController.sImagePath = self.sImagePath
                DestinationViewController.sUserId = self.sUserId
                DestinationViewController.sUserType = self.sUserType
                DestinationViewController.sRunging_year = self.sRunging_year
                DestinationViewController.sSchoolID = self.sSchoolID
                DestinationViewController.sFromWhere = "FromLogin"
            } else if sUserType == "teacher" {
                var DestinationViewController = segue.destination as! FingerPrintViewController
                DestinationViewController.sFromWhere = "FromLogin"
            } else if sUserType == ""{
                //            var DestinationViewController = segue.destination as! MainHomeViewController
                //            DestinationViewController.sUserId = self.sUserId
                //            DestinationViewController.sUserType = self.sUserType
                //            DestinationViewController.sSchoolID = self.sSchoolID
                //            DestinationViewController.sRunging_year = self.sRunging_year
            } 
        }
    }
    
    @IBAction func onClick_forgot(_ sender: UIButton) {
    }
    
    func initParams() {
        txtPasscode.text = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.count)! < 4 {
            return true
            // Else if 4 and delete is allowed
        }else if string.count == 0 {
            return true
            // Else limit reached
        }else{
            return false
        }
    }
}
