//
//  TeacherAttendanceViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/8/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class TeacherAttendanceViewController: UIViewController {
    var sClassIDs = [String]()
    var sClassNames = [String]()
    var sSectionNames = [[String]]()
    var sSessionIDs = [[String]]()
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gotoManageAttandenceViewController":
            var DestinationViewController = segue.destination as!
            ManageAttendanceViewController
            DestinationViewController.sClassIDs = self.sClassIDs
            DestinationViewController.sClassNames = self.sClassNames
            DestinationViewController.sSectionIDs = self.sSessionIDs
            DestinationViewController.sSectionNames = self.sSectionNames
        case "gotoAttendanceReportViewController":
            var DestinationViewController = segue.destination as! AttendanceReportViewController
            DestinationViewController.sClassIDs = self.sClassIDs
            DestinationViewController.sClassNames = self.sClassNames
            DestinationViewController.sSectionIDs = self.sSessionIDs
            DestinationViewController.sSectionNames = self.sSectionNames
        default:
            return
        }
    }

    @IBAction func onClick_btnManageAttendance(_ sender: UIButton, forEvent event: UIEvent) {
        self.sClassIDs.removeAll()
        self.sClassNames.removeAll()
        self.sSectionNames.removeAll()
        self.sSessionIDs.removeAll()
        
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/teacher_classes")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
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
                    let classes = parseData["classes"] as! [[String:Any]]
                    for classis in classes {
                        let sClassName = classis["name"] as! String
                        self.sClassNames.append(sClassName)
                        let sClassid = classis["class_id"] as! String
                        self.sClassIDs.append(sClassid)
                        let sessions = classis["sections"] as! [[String: Any]]
                        var tempSeesions = [String]()
                        var tempSessionIds = [String]()
                        for session in sessions{
                            let sSessionName = session["name"] as! String
                            tempSeesions.append(sSessionName)
                            let sSessionId = session["section_id"] as! String
                            tempSessionIds.append(sSessionId)
                        }
                        self.sSectionNames.append(tempSeesions)
                        self.sSessionIDs.append(tempSessionIds)
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "gotoManageAttandenceViewController", sender: self)
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            } catch let error as NSError {
                print(error)
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }
    
    @IBAction func onClick_btnAttendanceReport(_ sender: UIButton, forEvent event: UIEvent) {
        self.sClassIDs.removeAll()
        self.sClassNames.removeAll()
        self.sSectionNames.removeAll()
        self.sSessionIDs.removeAll()
        
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/teacher_classes")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
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
                    let classes = parseData["classes"] as! [[String:Any]]
                    for classis in classes {
                        let sClassName = classis["name"] as! String
                        self.sClassNames.append(sClassName)
                        let sClassid = classis["class_id"] as! String
                        self.sClassIDs.append(sClassid)
                        let sessions = classis["sections"] as! [[String: Any]]
                        var tempSeesions = [String]()
                        var tempSessionIds = [String]()
                        for session in sessions{
                            let sSessionName = session["name"] as! String
                            tempSeesions.append(sSessionName)
                            let sSessionId = session["section_id"] as! String
                            tempSessionIds.append(sSessionId)
                        }
                        self.sSectionNames.append(tempSeesions)
                        self.sSessionIDs.append(tempSessionIds)
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "gotoAttendanceReportViewController", sender: self)
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            } catch let error as NSError {
                print(error)
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }
    
}
