//
//  AttendanceHistoryViewController.swift
//  Rarome
//
//  Created by AntonDream on 10/3/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AttendanceHistoryViewController: UIViewController {
    
    @IBOutlet weak var tbl_attendanceHistory: UITableView!
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")

    var sMonth = String()
    var sStudent_id = String()
    
    var sDates = [String]()
    var sAttendanceStatus = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataToServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClick_btnOUtside(_ sender: UIButton, forEvent event: UIEvent) {
        dismiss(animated: true, completion: nil )
    }

    func getDataToServer(){        
        var Param : [String:Any] = [:]
        Param["school_id"] = GlobalConst.glb_sSchoolID!
        Param["running_year"] = GlobalConst.glb_sRunning_year!
        Param["user_type"] = GlobalConst.glb_sUserType!
        Param["user_id"] = GlobalConst.glb_sUserId!
        Param["student_id"] = sMonth
        Param["month"] = sStudent_id
        var postString = String()
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: Param,
            options: []) {
            postString = String(data: theJSONData, encoding: .ascii)!
        }
        
        present(processDialog, animated: true, completion: nil)
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/native_get_student_month_attendance")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postString.data(using: .utf8)
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
                    DispatchQueue.main.async(execute: {
                        self.processDialog.dismiss(animated: true, completion: nil)
                        var alert = UIAlertController(title: "Result", message: sMessage, preferredStyle: UIAlertControllerStyle.alert)
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
                    })                }
                DispatchQueue.main.async(execute: {
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
