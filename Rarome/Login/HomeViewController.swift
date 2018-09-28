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
    
    @IBOutlet weak var txt_passcode1: UITextField!
    @IBOutlet weak var txt_passcode2: UITextField!
    @IBOutlet weak var txt_passcode3: UITextField!
    @IBOutlet weak var txt_passcode4: UITextField!
    
    @IBOutlet weak var txt_confirm1: UITextField!
    @IBOutlet weak var txt_confirm2: UITextField!
    @IBOutlet weak var txt_confirm3: UITextField!
    @IBOutlet weak var txt_confirm4: UITextField!
    
    @IBOutlet weak var btn_submit: UIButton!
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    var sName: String!
    var sEmail: String!
    var sImagePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txt_passcode1.delegate = self
        self.txt_passcode2.delegate = self
        self.txt_passcode3.delegate = self
        self.txt_passcode4.delegate = self
        
        self.txt_confirm1.delegate = self
        self.txt_confirm2.delegate = self
        self.txt_confirm3.delegate = self
        self.txt_confirm4.delegate = self
        
        btn_passcode.setImage(UIImage(named:"radio_unclick"), for: .normal)
        btn_passcode.setImage(UIImage(named:"radio_click"), for: .selected)
        btn_passcode.isSelected = true

        btn_fingerprint.setImage(UIImage(named:"radio_unclick"), for: .normal)
        btn_fingerprint.setImage(UIImage(named:"radio_click"), for: .selected)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! ComfirmPasscodeViewController
        DestinationViewController.sPassword = "\(txt_passcode1.text)\(txt_passcode2.text)\(txt_passcode3.text)\(txt_passcode4.text)"
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
        var sPassword: String = "\(txt_passcode1.text)\(txt_passcode2.text)\(txt_passcode3.text)\(txt_passcode4.text)"
        var sConfirm: String = "\(txt_confirm1.text)\(txt_confirm2.text)\(txt_confirm3.text)\(txt_confirm4.text)"
        if sPassword != sConfirm {
            var alert = UIAlertController(title: "Error", message: "Password in not equal to Confirm Password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    self.initParams()
                    self.txt_passcode1.becomeFirstResponder()
                    return
                case .cancel:
                    self.initParams()
                    self.txt_passcode1.becomeFirstResponder()
                    return
                case .destructive:
                    self.initParams()
                    self.txt_passcode1.becomeFirstResponder()
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
            }
        }

        self.performSegue(withIdentifier: "gotoConfirmViewController", sender: self)
    }
    @IBAction func onChang_txt1(_ sender: UITextField, forEvent event: UIEvent) {
        self.txt_passcode2.becomeFirstResponder()
    }
    

    @IBAction func onChang_txt2(_ sender: UITextField, forEvent event: UIEvent) {
        self.txt_passcode3.becomeFirstResponder()
    }
    
    @IBAction func onChang_txt3(_ sender: UITextField, forEvent event: UIEvent) {
        self.txt_passcode4.becomeFirstResponder()
    }
    
    @IBAction func onChang_txt5(_ sender: UITextField, forEvent event: UIEvent) {
        self.txt_confirm2.becomeFirstResponder()
    }
    
    @IBAction func onChang_txt6(_ sender: UITextField, forEvent event: UIEvent) {
        self.txt_confirm3.becomeFirstResponder()
    }
    
    @IBAction func onChang_txt7(_ sender: UITextField, forEvent event: UIEvent) {
        self.txt_confirm4.becomeFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    func initParams(){
        txt_passcode1.text = nil
        txt_passcode2.text = nil
        txt_passcode3.text = nil
        txt_passcode4.text = nil
        txt_confirm1.text = nil
        txt_confirm2.text = nil
        txt_confirm3.text = nil
        txt_confirm4.text = nil
    }
}
