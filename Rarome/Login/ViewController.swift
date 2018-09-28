//
//  ViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/19/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import Foundation
import TextFieldEffects
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var mTxt_email: HoshiTextField!
    @IBOutlet weak var mTxt_password: HoshiTextField!
    @IBOutlet weak var mBtn_login: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    var sName: String!
    var sEmail: String!
    var sImagePath: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mTxt_password.delegate = self
        self.mTxt_email.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! HomeViewController
        DestinationViewController.sUserId = self.sUserId
        DestinationViewController.sUserType = self.sUserType
        DestinationViewController.sSchoolID = self.sSchoolID
        DestinationViewController.sRunging_year = self.sRunging_year
        DestinationViewController.sName = self.sName
        DestinationViewController.sEmail = mTxt_email.text
        DestinationViewController.sImagePath = self.sImagePath
        
        
        let permissionState = UserDefaults.standard
        permissionState.set(self.sUserId, forKey: "sUserId")
        permissionState.set(self.sUserType, forKey: "sUserType")
        permissionState.set(self.sSchoolID, forKey: "sSchoolID")
        permissionState.set(self.sRunging_year, forKey: "sRunging_year")
        permissionState.set(self.sName, forKey: "sName")
        permissionState.set(mTxt_email.text, forKey: "sEmail")
        permissionState.set(self.sImagePath, forKey: "sImagePath")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:50), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    @IBAction func onClick_btn_login(_ sender: UIButton, forEvent event: UIEvent) {
        present(processDialog, animated: true, completion: nil)
        var sEmail: String = mTxt_email.text!
        var sPassword: String = mTxt_password.text!
        if sEmail.isEmpty == true{
            return
        }
        if sPassword.isEmpty == true{
            return
        }
        let url = URL(string: "https://demo.rarome.com/index.php/?api/webview_login_app")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var sDeviceToken: String = ""
        var iDeviceID: String = (UIDevice.current.identifierForVendor?.uuidString)!
        let postString = "deviceToken=\(sDeviceToken)&device_id=\(iDeviceID)&deviceType=ios&email=\(sEmail)&password=\(sPassword)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let iStatus = parseData["status"] as! Int
                let sMessage = parseData["message"] as! String
                if iStatus == 1 {
                    self.sUserId = parseData["user_id"] as! String
                    self.sUserType = parseData["user_type"] as! String
                    self.sSchoolID = parseData["school_id"] as! String
                    self.sRunging_year = parseData["running_year"] as! String
                    self.sName = parseData["name"] as! String
                    self.sImagePath = parseData["student_img_path"] as! String
                }
                self.gotoHome(iStatus: iStatus, sMessage: sMessage);
            } catch let error as NSError {
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }
    
    func gotoHome(iStatus:Int, sMessage:String) {
        if iStatus == 0 {
            DispatchQueue.main.async(execute: {
                self.processDialog.dismiss(animated: true, completion: nil)
                var alert = UIAlertController(title: "Error", message: sMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        return
                    case .cancel:
                        return
                    case .destructive:
                        print("destructive")
                        return
                    }}))
                self.present(alert, animated: true, completion: nil)
            })
        }
        if    sMessage == "success"{
            DispatchQueue.main.async(execute: {
                self.processDialog.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "gotoHomeSegue", sender: self)
                GlobalConst.glb_sUserId = self.sUserId
                GlobalConst.glb_sSchoolID = self.sSchoolID
                GlobalConst.glb_sUserType = self.sUserType
                GlobalConst.glb_sRunning_year = self.sRunging_year
                GlobalConst.glb_studentImg_path = self.sImagePath
            })
        }
    }
}

