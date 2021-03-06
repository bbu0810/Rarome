//
//  StudentAttendanceViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/16/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown
import DatePickerDialog
class StudentAttendanceViewController: UIViewController {
    
    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var btn_selectClass: UIButton!
    @IBOutlet weak var view_selectClassDrop: UIView!
    
    @IBOutlet weak var view_selectSection: UIView!
    @IBOutlet weak var btn_selectSection: UIButton!
    @IBOutlet weak var view_selectSectionDrop: UIView!
    
    @IBOutlet weak var view_selectFromDate: UIView!
    @IBOutlet weak var btn_selectFromDate: UIButton!
    
    @IBOutlet weak var view_slectToDate: UIView!
    @IBOutlet weak var btn_selectToDate: UIButton!
    
    var classNames = [String]()
    var classID = [String]()
    
    var sectionNmaes = [[String]]()
    var sectionIDs = [[String]]()
    
    var selectClass: Int!
    var selectSection: Int!
    
    var firstDate = String()
    var secondDate = String()
    
    var studentNames = [String]()
    var studentIDs = [String]()
    var studenImgURL = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClassNames()
        buildUI()
        initParams()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! StudentsOfClassSectionTableViewController
        DestinationViewController.studentNames = self.studentNames
        DestinationViewController.studentIDs = self.studentIDs
        DestinationViewController.studenImgURL = self.studenImgURL
        DestinationViewController.firstDate = self.firstDate
        DestinationViewController.secondDate = self.secondDate
    }
    
    @IBAction func onClick_btnselectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClassDrop
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectClass .setTitle(item, for: UIControlState.normal)
            self.btn_selectSection.setTitle("Select Secssion", for: UIControlState.normal)
            self.selectClass = index
            self.selectSection = -1
        }
        dropDown.width = view_selectClassDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_btnSelectSession(_ sender: UIButton, forEvent event: UIEvent) {
        if selectClass < 0 {
            return
        }
        let dropDown = DropDown()
        dropDown.anchorView = view_selectSectionDrop
        dropDown.dataSource = self.sectionNmaes[selectClass]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectSection.setTitle(self.sectionNmaes[self.selectClass][index], for: UIControlState.normal)
            self.selectSection = index
        }
        dropDown.width = view_selectSectionDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_btnSelectFromDate(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_btnSelectToDate(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_submit(_ sender: UIButton, forEvent event: UIEvent) {
        if selectClass < 0 || selectSection < 0 {
            return
        }
        firstDate = btn_selectFromDate.title(for: .normal)!
        secondDate = btn_selectToDate.title(for: .normal)!
        if firstDate.count < 5 || secondDate.count < 5 {
            return
        }
        getStudentsOfClassSection()
    }
    
    func buildUI(){
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        view_selectClass.layer.borderWidth = 1
        view_selectClass.layer.cornerRadius = 5
        view_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        view_selectSection.layer.borderWidth = 1
        view_selectSection.layer.cornerRadius = 5
        view_selectSection.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        view_selectFromDate.layer.borderWidth = 1
        view_selectFromDate.layer.cornerRadius = 5
        view_selectFromDate.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        view_slectToDate.layer.borderWidth = 1
        view_slectToDate.layer.cornerRadius = 5
        view_slectToDate.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func initParams(){
        selectClass = -1
        selectSection = -1
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
                    var sectionNameArray = [String]()
                    var sectionIDArray = [String]()
                    for result in sResult {
                        if let sClassName = result["name"] as? String {
                            self.classNames.append(sClassName)
                        }
                        if let sClassID = result["class_id"] as? String {
                            self.classID.append(sClassID)
                        }
                        if let sections = result["sections"] as? [[String:AnyObject]]{
                            for section in sections {
                                let sectionName = section["name"] as? String
                                let sectionID = section["section_id"] as? String
                                sectionNameArray.append(sectionName!)
                                sectionIDArray.append(sectionID!)
                            }
                        }
                        self.sectionNmaes.append(sectionNameArray)
                        self.sectionIDs.append(sectionIDArray)
                        sectionNameArray.removeAll()
                        sectionIDArray.removeAll()
                    }
                    
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getStudentsOfClassSection(){
        self.studentNames.removeAll()
        self.studentIDs.removeAll()
        self.studenImgURL.removeAll()
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let class_id: String = self.classID[selectClass]
        let section_id: String = self.sectionIDs[selectClass][selectSection]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_all_students_by_class_section")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&class_id=\(class_id)&section_id=\(section_id)"
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
                    let sResult = parseData["student_information_list"] as! [[String:AnyObject]]
                    for result in sResult {
                        let sStudentName = result["name"] as? String
                        let sLName = result["lname"] as? String
                        let sFullName: String!
                        sFullName = "\(sStudentName ?? "") \(sLName ?? "")"
                        self.studentNames.append(sFullName)
                        if let sStudentId = result["student_id"] as? String {
                            self.studentIDs.append(sStudentId)
                        }
                        let sStudentImgURL = result["stud_image"] as? String
                        if (sStudentImgURL == nil){
                            self.studenImgURL.append("")
                        } else {
                            self.studenImgURL.append(sStudentImgURL!)
                        }
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "gotoStudemtsOfClassSection", sender: self)
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
}
