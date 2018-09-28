//
//  Student_WiseViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/26/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Foundation
import DropDown
class Student_WiseViewController: UIViewController, IndicatorInfoProvider {

    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var btn_selectClass: UIButton!
    @IBOutlet weak var btn_selectStudent: UIButton!
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var view_selectStudent: UIView!
    
    @IBOutlet weak var view_top1: UIView!
    @IBOutlet weak var lbl_titleEnrollCode: UILabel!
    @IBOutlet weak var lbl_enrollCode: UILabel!
    @IBOutlet weak var lbl_titleStudentName: UILabel!
    @IBOutlet weak var lbl_studentName: UILabel!
    @IBOutlet weak var lbl_titleGrade: UILabel!
    @IBOutlet weak var lbl_grade: UILabel!
    @IBOutlet weak var lbl_titleDateOfAdmission: UILabel!
    @IBOutlet weak var lbl_dateOfAdmission: UILabel!
    
    @IBOutlet weak var view_schoolFee: UIView!
    @IBOutlet weak var lbl_titleSchoolFee: UILabel!
    @IBOutlet weak var lbl_schoolFee: UILabel!
    
    @IBOutlet weak var view_hostFee: UIView!
    @IBOutlet weak var lbl_titleHostelFee: UILabel!
    @IBOutlet weak var lbl_hostelFee: UILabel!
    
    @IBOutlet weak var view_transportFee: UIView!
    @IBOutlet weak var lbl_titleTransportFee: UILabel!
    @IBOutlet weak var lbl_transportFee: UILabel!
    
    @IBOutlet weak var view_messFee: UIView!
    @IBOutlet weak var lbl_titleMessFee: UILabel!
    @IBOutlet weak var lbl_messFee: UILabel!
    
    var classNames = [String]()
    var classID = [String]()
    var studentName = [String]()
    var studentID = [String]()
    var sEnrollCode: String!
    var sGrade: String!
    var sDataOfAdmission: String!
    var sSchoolFee: String!
    var sHostelFee: String!
    var sTransportFee: String!
    var sMessFee: String!
   
    var selectClass: Int!
    var selectStudent: Int!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        selectClass = -1
        selectStudent = -1
        getClass()
        buildinUI()
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Student-Wise")
    }
    @IBAction func onClick_selectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClass
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectClass.setTitle(item, for: .normal)
            self.selectClass = index            
            self.btn_selectStudent.setTitle("Select Student", for: .normal)
            self.getStudent()
        }
        dropDown.width = btn_selectClass.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectStudent(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClass
        dropDown.dataSource = self.studentName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectStudent.setTitle(item, for: .normal)
            self.selectStudent = index
            self.getStudentFee()
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
    
    func getStudent(){
        if selectClass < 0 {
            return
        }
        self.studentName.removeAll()
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
                        let sStudentName = result["name"] as? String
                        let sLName = result["lname"] as? String
                        let sFullName: String!
                        sFullName = "\(sStudentName ?? "") \(sLName ?? "")"
                        self.studentName.append(sFullName!)
                        let studentID = result["student_id"] as? String
                        self.studentID.append(studentID!)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getStudentFee(){
        if selectClass < 0 {
            return
        }
        if selectStudent < 0 {
            return
        }
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let student_id: String = studentID[selectStudent]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_student_wise_dues")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&student_id=\(student_id)"
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
                    let sResult = parseData["student_detail"] as! [String:AnyObject]
                    self.sEnrollCode = sResult["enroll_code"] as? String
                    self.sGrade = sResult["class"] as? String
                    self.sDataOfAdmission = sResult["date_joined"] as? String
                    let sRecords = parseData["records"] as! [String:AnyObject]
                    self.sSchoolFee = sRecords["school_fee"] as? String
                    self.sHostelFee = sRecords["hostel_fee"] as? String
                    self.sTransportFee = sRecords["transport_fee"] as? String
                    self.sMessFee = sRecords["mess_fee"] as? String
                    
                }
                self.resultShow()
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }

    func buildinUI(){
        btn_selectClass.layer.borderWidth = 1
        btn_selectClass.layer.cornerRadius = 5
        btn_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        btn_selectStudent.layer.borderWidth = 1
        btn_selectStudent.layer.cornerRadius = 5
        btn_selectStudent.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_top.layer.borderWidth = 1
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func resultShow(){
        DispatchQueue.main.async(execute: {
            self.view_top1.layer.borderWidth = 1
            self.view_top1.layer.cornerRadius = 5
            self.view_top1.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
            
            self.lbl_titleEnrollCode.text = "Enroll Code"
            self.lbl_enrollCode.text = self.sEnrollCode
            self.lbl_titleStudentName.text = "Student Name"
            self.lbl_studentName.text = self.studentName[self.selectStudent]
            self.lbl_titleGrade.text = "Grade"
            self.lbl_grade.text = self.sGrade
            self.lbl_titleDateOfAdmission.text = "Date of Admission"
            self.lbl_dateOfAdmission.text = self.sDataOfAdmission
            
            self.view_schoolFee.layer.borderWidth = 1
            self.view_schoolFee.layer.cornerRadius = 5
            self.view_schoolFee.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
            
            self.lbl_titleSchoolFee.text = "School Fee"
            if self.sSchoolFee == nil {
                self.lbl_schoolFee.text = "No Fee Assigned"
            } else {
                self.lbl_schoolFee.text = self.sSchoolFee
            }
            
            self.view_hostFee.layer.borderWidth = 1
            self.view_hostFee.layer.cornerRadius = 5
            self.view_hostFee.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
            
            self.lbl_titleHostelFee.text = "Hostel Fee"
            if self.sHostelFee == nil {
                self.lbl_hostelFee.text = "No Fee Assigned"
            } else {
                self.lbl_hostelFee.text = self.sHostelFee
            }
            
            self.view_transportFee.layer.borderWidth = 1
            self.view_transportFee.layer.cornerRadius = 5
            self.view_transportFee.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
            
            self.lbl_titleTransportFee.text = "Transport Fee"
            if self.sTransportFee == nil {
                self.lbl_transportFee.text = "No Fee Assigned"
            } else {
                self.lbl_transportFee.text = self.sHostelFee
            }
            
            self.view_messFee.layer.borderWidth = 1
            self.view_messFee.layer.cornerRadius = 5
            self.view_messFee.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
            
            self.lbl_titleMessFee.text = "Mess Fee"
            if self.sMessFee == nil {
                self.lbl_messFee.text = "No Fee Assigned"
            } else {
                self.lbl_messFee.text = self.sMessFee
            }
        })
    }
    
}
































