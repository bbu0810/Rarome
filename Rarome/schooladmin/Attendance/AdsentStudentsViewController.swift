//
//  AdsentStudentsViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/16/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DatePickerDialog
import DropDown
class AdsentStudentsViewController: UIViewController {    
    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var btn_selectClass: UIButton!
    @IBOutlet weak var view_selectClassDrop: UIView!
    
    @IBOutlet weak var view_selectDate: UIView!
    @IBOutlet weak var btn_selectDate: UIButton!
    
    var classNames = [String]()
    var classID = [String]()
    
    var index = Int()
    
    var studentsNames = [String]()
    var sectionNames = [String]()
    var attendances = [String]()
    
    var filterStudentNames = [String]()
    var filterSectionNames = [String]()
    var filterAttendanceNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClassNames()
        bulidUI()
        index = -1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestinationViewController = segue.destination as! AdsentStudensTableViewController
        DestinationViewController.className = self.classNames[index]
        DestinationViewController.studentNames = self.studentsNames
        DestinationViewController.sectionNames = self.sectionNames
    }
    
    @IBAction func onClick_selectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClassDrop
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectClass.setTitle(self.classNames[index], for: .normal)
            self.index = index
        }
        dropDown.width = view_selectClassDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectDate(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_viewAttendace(_ sender: UIButton, forEvent event: UIEvent) {
        if(self.index < 0){
            return
        }
        getStudents()
    }
    
    func bulidUI(){
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectClass.layer.borderWidth = 1
        view_selectClass.layer.cornerRadius = 5
        view_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectDate.layer.borderWidth = 1
        view_selectDate.layer.cornerRadius = 5
        view_selectDate.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func getClassNames(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_classes_with_sections_by_school_wise")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)"
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
                    let sResult = parseData["classes"] as! [[String:AnyObject]]
                    for result in sResult {
                        if let sClassName = result["name"] as? String {
                            self.classNames.append(sClassName)
                        }
                        if let sClassID = result["class_id"] as? String {
                            self.classID.append(sClassID)
                        }
                    }
                    
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getStudents(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let date = self.btn_selectDate.title(for: .normal) ?? ""
        let class_id = self.classID[index]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_absent_students")!
        
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&date=\(date)&class_id=\(class_id)"
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
                    let sResult = parseData["records"] as! [[String:AnyObject]]
                    for result in sResult {
                        let sStudentName = result["name"] as? String
                        let sLName = result["lname"] as? String
                        let sFullName: String!
                        sFullName = "\(sStudentName ?? "") \(sLName ?? "")"
                        self.studentsNames.append(sFullName)
                        let section = result["section_name"] as? String
                        self.sectionNames.append(section!)
                        let attendance = result["present"] as? String
                        if attendance == nil {
                            self.attendances.append("0")
                        } else {
                            self.attendances.append(attendance!)
                        }
                    }
                    
                }
                DispatchQueue.main.async(execute: {
                    self.filterStudents()
                    self.performSegue(withIdentifier: "gotoAttendanceTable", sender: self)
                })                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func datePickerTapped(button: UIButton) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let date = formatter.string(from: dt)
                button.setTitle(date, for: .normal)
            }
        }
    }
    
    func filterStudents(){
        let count = self.attendances.count
        for i in stride(from: 0, to: count, by: 1) {
            if attendances[i] == "1"{                
            }else{
                filterStudentNames.append(self.studentsNames[i])
                filterSectionNames.append(self.sectionNames[i])
            }
        }
    }
}
