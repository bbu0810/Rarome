//
//  HomeViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/20/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import LocalAuthentication

class HomeViewController: UIViewController, UITextFieldDelegate{
    

    @IBOutlet weak var btn_passcode: UIButton!
    @IBOutlet weak var btn_fingerprint: UIButton!
    
    @IBOutlet weak var txt_enterPasscode: UITextField!
    @IBOutlet weak var txt_confirmPasscode: UITextField!

    @IBOutlet weak var btn_submit: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    var sName: String!
    var sEmail: String!
    var sImagePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GlobalConst.glb_bUseFingerPrint = false
        
        txt_enterPasscode.defaultTextAttributes.updateValue(25, forKey: NSKernAttributeName)
        txt_confirmPasscode.defaultTextAttributes.updateValue(25, forKey: NSKernAttributeName)
        
        self.txt_enterPasscode.delegate = self
        self.txt_confirmPasscode.delegate = self
        
        btn_passcode.setImage(UIImage(named:"radio_unclick"), for: .normal)
        btn_passcode.setImage(UIImage(named:"radio_click"), for: .selected)
        btn_passcode.isSelected = true

        btn_fingerprint.setImage(UIImage(named:"radio_unclick"), for: .normal)
        btn_fingerprint.setImage(UIImage(named:"radio_click"), for: .selected)
        
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:200), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! ComfirmPasscodeViewController
        DestinationViewController.sPassword = self.txt_confirmPasscode.text
        if btn_fingerprint.isSelected == true {
            DestinationViewController.bFingerprintEnable = true
        }
        DestinationViewController.sUserId = self.sUserId
        DestinationViewController.sUserType = self.sUserType
        DestinationViewController.sSchoolID = self.sSchoolID
        DestinationViewController.sRunging_year = self.sRunging_year
        DestinationViewController.sName = self.sName
        DestinationViewController.sEmail = self.sEmail
        DestinationViewController.sImagePath = self.sImagePath

    }

    @IBAction func onClick_passcode(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        if btn_passcode.isSelected == true {
            btn_fingerprint.isSelected = true
        } else {
            btn_fingerprint.isSelected = false
        }
    }
    
    @IBAction func onClick_fingerprint(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        if btn_fingerprint.isSelected == true {
            btn_passcode.isSelected = true
        } else {
            btn_passcode.isSelected = false
        }
    }
    
    @IBAction func onClick_submit(_ sender: UIButton) {
        let sPassword = txt_enterPasscode.text ?? ""
        let sConfirm = txt_confirmPasscode.text ?? ""
        if (sPassword.count < 4) {
            var alert = UIAlertController(title: "Error", message: "Password length must be 4 digits", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    return
                case .cancel:
                    return
                case .destructive:
                    return
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        if sPassword != sConfirm {
            var alert = UIAlertController(title: "Error", message: "Passcode is not equal to Confirm Passcode", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    self.initParams()
                    return
                case .cancel:
                    self.initParams()
                    return
                case .destructive:
                    self.initParams()
                    return
                }}))
            self.present(alert, animated: true, completion: nil)
        }
        if btn_fingerprint.isSelected == true {
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) == false{
                let ac = UIAlertController(title: "Touch ID not available", message: "Your device is not configured for Touch ID.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                self.initParams()
                return
            } else {
                GlobalConst.glb_bUseFingerPrint = true
            }
        }

        self.performSegue(withIdentifier: "gotoConfirmViewController", sender: self)
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let maxLength = 4
//        let currentString: NSString = textField.text! as NSString
//        let newString: NSString =
//            currentString.replacingCharacters(in: range, with: string) as NSString
//        return newString.length <= maxLength
//    }
    
    func initParams(){
    }
}
