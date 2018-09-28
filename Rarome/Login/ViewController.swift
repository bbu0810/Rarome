//
//  ViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/19/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var mTxt_email: UITextField!
    @IBOutlet weak var mTxt_password: UITextField!
    @IBOutlet weak var mBtn_login: UIButton!
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    var sName: String!
    var sEmail: String!
    var sImagePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    }
    
    @IBAction func onClick_btn_login(_ sender: Any) {
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
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
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
                print(error)
            }
        }
        task.resume()
    }

    func gotoHome(iStatus:Int, sMessage:String) {
        if iStatus == 0 {
            DispatchQueue.main.async(execute: {
                var alert = UIAlertController(title: "Error", message: sMessage, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                    case .default:
                        print("default")
                        return
                    case .cancel:
                        print("cancel")
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

