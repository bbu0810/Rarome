//
//  AttendanceViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/24/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController {
    @IBOutlet weak var layout_titakStudents: UIStackView!
    @IBOutlet weak var view_total_students: UIView!
    @IBOutlet weak var label_total_count: UIView!
    
    @IBOutlet weak var lbl_totalStudents: UILabel!
    @IBOutlet weak var lbl_presentStudents: UILabel!
    @IBOutlet weak var lbl_absentStudents: UILabel!
    
    var total = String()
    var present = String()
    var absent = Int()
    override func viewDidLoad() {
        getCurrentAttendace()
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onClick_studentAttendance(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    @IBAction func onClick_absentStudents(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    @IBAction func onClick_dailyAttendence(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    func getCurrentAttendace(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let currentDate = Date()
        let formatter = DateFormatter()
        let date = formatter.string(from: currentDate)
        formatter.dateFormat = "yyyy-MM-dd"
        let url = URL(string: "https://demo.rarome.com/index.php/?api/attendance_states")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&date=\(date)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let iStatus = parseData["status"] as! Int
                let sMessage = parseData["message"] as! String
                if iStatus == 1 {
                    let total = parseData["total"] as? String
                    self.total = total!
                    let present = parseData["present"] as? String
                    self.present = present!
                    let absent = parseData["absent"] as? Int
                    self.absent = absent!
                }
                DispatchQueue.main.async(execute: {
                    self.lbl_absentStudents.text = String(self.absent)
                    self.lbl_presentStudents.text = String(self.present)
                    self.lbl_totalStudents.text = String(self.total)
                })
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
}
