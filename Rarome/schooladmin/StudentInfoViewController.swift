//
//  StudentInfoViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/28/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import Foundation
import DropDown



class StudentInfoViewController: UIViewController{
    
    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var btn_selectClass: UIButton!    
    @IBOutlet weak var btn_selectSection: UIButton!
    
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var view_selectSection: UIView!

    

    var studentInfo = [String]()
    var classNames = [String]()
    var classID = [String]()
    var sectionID = [String]()
    var studentNames = [String]()
    var studentIDs = [String]()
    var sectionNmaes = [String]()
    var fatherNames = [String]()
    var motherNames = [String]()
    var gender = [String]()
    var emergencyContact = [String]()
    var uniquSectionName = [String]()
    var studenImgURL = [String]()
    
    var filterStudentName = [String]()
    var filterFatherName = [String]()
    var filterMotherName = [String]()
    var filterGender = [String]()
    var filterEmergency = [String]()
    var filterStudentID = [String]()
    var filterStudentImgURL = [String]()
    
    var selectClass: Int!
    var selectSection: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectClass = -1
        getClass()
        buildinUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        var DestinationViewController = segue.destination as! StudentTableViewController
        DestinationViewController.studentsNames = self.filterStudentName
        DestinationViewController.fatherNames = self.filterFatherName
        DestinationViewController.motherNames = self.filterMotherName
        DestinationViewController.gentherName = self.filterGender
        DestinationViewController.emergency = self.filterEmergency
        DestinationViewController.studentIDs = self.filterStudentID
        DestinationViewController.studentImgURL = self.filterStudentImgURL
    }
    
    @IBAction func onClick_selectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClass
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            GlobalConst.glb_studentGrade = item
            self.btn_selectClass.setTitle(item, for: .normal)
            self.selectClass = index
            self.getSections()
            self.btn_selectSection.setTitle("Select Section", for: .normal)
        }
        dropDown.width = btn_selectClass.frame.width
        dropDown.show()
    }
    
    
    @IBAction func onClick_selectSection(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectSection
        dropDown.dataSource = self.uniquSectionName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectSection.setTitle(item, for: .normal)
            self.selectSection = item
            self.filterStudents(section: item)
            self.performSegue(withIdentifier: "gotoStudentTable", sender: self)
        }
        dropDown.width = btn_selectClass.frame.width
        dropDown.show()

    }
    
    func getClass(){
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
                        if let sSection_name = result["name"] as? String {
                            self.classNames.append(sSection_name)
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
    
    func getSections(){
        if selectClass < 0 {
            return
        }
        sectionNmaes.removeAll()
        studentNames.removeAll()
        fatherNames.removeAll()
        motherNames.removeAll()
        gender.removeAll()
        emergencyContact.removeAll()
        studentIDs.removeAll()
        studenImgURL.removeAll()
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let class_id: String = classID[selectClass]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_all_students_by_class")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&class_id=\(class_id)"
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
                        let sSectionName = result["section_name"] as! String
                        self.sectionNmaes.append(sSectionName)
                        
                        let sStudentName = result["name"] as? String
                        let sStudentLName = result["lname"] as? String
                        let sStudentFullName: String!
                        sStudentFullName = "\(sStudentName ?? "") \(sStudentLName ?? "")"
                        self.studentNames.append(sStudentFullName)
                        
                        let sFatherName = result["father_name"] as? String
                        let sFatherLName = result["father_lname"] as? String
                        let sFatherFullName: String!
                        sFatherFullName = "\(sFatherName ?? "") \(sFatherLName ?? "")"
                        self.fatherNames.append(sFatherFullName)
                        let sMotherName = result["mother_name"] as? String
                        let sMatherLName = result["mother_lname"] as? String
                        let sMotherFullName: String!
                        sMotherFullName = "\(sMotherName ?? "") \(sMatherLName ?? "")"
                        self.motherNames.append(sMotherFullName)
                        let sGender = result["sex"] as! String
                        self.gender.append(sGender)
                        let sEmergency = result["emergency_contact_number"] as? String
                        if (sEmergency == nil) {
                            self.emergencyContact.append("")
                        } else{
                            self.emergencyContact.append(sEmergency!)
                        }
                        let sStudentID = result["student_id"] as? String
                        self.studentIDs.append(sStudentID!)
                        let sStudentImgURL = result["stud_image"] as? String
                        if (sStudentImgURL == nil){
                            self.studenImgURL.append("")
                        } else {
                            self.studenImgURL.append(sStudentImgURL!)
                        }
                        
                    }                    
                    self.shortSection()
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func shortSection(){
        DispatchQueue.main.async(execute: {
            self.uniquSectionName = Array(Set(self.sectionNmaes))
            self.uniquSectionName.sort()
        })
    }
    
    func buildinUI(){
        btn_selectClass.layer.borderWidth = 1
        btn_selectClass.layer.cornerRadius = 5
        btn_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        btn_selectSection.layer.borderWidth = 1
        btn_selectSection.layer.cornerRadius = 5
        btn_selectSection.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_top.layer.borderWidth = 1
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func filterStudents(section: String){
         self.filterStudentName.removeAll()
         self.filterFatherName.removeAll()
         self.filterMotherName.removeAll()
         self.filterGender.removeAll()
         self.filterEmergency.removeAll()
         self.filterStudentID.removeAll()
        self.filterStudentImgURL.removeAll()
        for i in 0 ..< sectionNmaes.count{
            if sectionNmaes[i] == section {
                self.filterStudentName.append(self.studentNames[i])
                self.filterFatherName.append(self.fatherNames[i])
                self.filterMotherName.append(self.motherNames[i])
                self.filterGender.append(self.gender[i])
                self.filterEmergency.append(self.emergencyContact[i])
                self.filterStudentID.append(self.studentIDs[i])
                self.filterStudentImgURL.append(self.studenImgURL[i])
            }
        }
    }
    
    
}
