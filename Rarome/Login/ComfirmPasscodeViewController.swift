//
//  ComfirmPasscodeViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/22/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class ComfirmPasscodeViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var txtPass1: UITextField!
    @IBOutlet weak var txtPass2: UITextField!
    @IBOutlet weak var txtPass3: UITextField!
    @IBOutlet weak var txtPass4: UITextField!
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtPass1.delegate = self
        self.txtPass2.delegate = self
        self.txtPass3.delegate = self
        self.txtPass4.delegate = self
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
        } else {
            var DestinationViewController = segue.destination as! MainHomeViewController
                DestinationViewController.sUserId = self.sUserId
                DestinationViewController.sUserType = self.sUserType
                DestinationViewController.sSchoolID = self.sSchoolID
                DestinationViewController.sRunging_year = self.sRunging_year
        }
    }

    @IBAction func onChang_txt1(_ sender: UITextField) {
        self.txtPass2.becomeFirstResponder()
    }
    
    @IBAction func onChang_txt2(_ sender: UITextField) {
        self.txtPass3.becomeFirstResponder()
    }
    
    @IBAction func onChang_txt3(_ sender: UITextField) {
        self.txtPass4.becomeFirstResponder()
    }
    
    @IBAction func onChang_txt4(_ sender: UITextField) {
        sConfirmPassword = "\(txtPass1.text)\(txtPass2.text)\(txtPass3.text)\(txtPass4.text)"
        if sPassword == sConfirmPassword {
            if self.sUserType == "school_admin"{
                self.performSegue(withIdentifier: "gotoAdminDashboardViewController", sender: self)
            } else {
                self.performSegue(withIdentifier: "gotoMainHomeViewController", sender: self)
            }
        } else {
            return
        }
        
    }
    
    @IBAction func onClick_forgot(_ sender: UIButton) {
    }
    
    func initParams() {
        txtPass1 = nil
        txtPass2 = nil
        txtPass3 = nil
        txtPass4 = nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    

}
