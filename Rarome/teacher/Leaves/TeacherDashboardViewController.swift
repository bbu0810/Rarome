//
//  TeacherDashboardViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/28/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class TeacherDashboardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    @IBAction func onClickMessage(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickLeaves(_ sender: UIButton, forEvent event: UIEvent) {
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
    @IBAction func onClickProgressReport(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickAttendance(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickAssignment(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickHomeWork(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickViewPayslip(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickStudentsInfo(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    
    
}
