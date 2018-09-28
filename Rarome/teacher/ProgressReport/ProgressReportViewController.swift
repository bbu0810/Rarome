//
//  ProgressReportViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/4/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown
class ProgressReportViewController: UIViewController {
    
    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var btn_select: UIButton!
    @IBOutlet weak var view_selectClassDrop: UIView!
    
    @IBOutlet weak var view_selectSection: UIView!
    @IBOutlet weak var btn_selectSection: UIButton!
    @IBOutlet weak var view_selectSectionDrop: UIView!
    
    @IBOutlet weak var view_selectSubject: UIView!
    @IBOutlet weak var btn_selectSubject: UIButton!
    @IBOutlet weak var view_selectSubjectDrop: UIView!
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    
    var sClasses = [String]()
    var sClassIDs = [String]()
    var selectedClass = -1
    var sSessions = [[String]]()
    var sSessionIDs = [[String]]()
    var selectedSectionID = -1
    var sSubjectNames = [String]()
    var sSubjectIDs = [String]()
    var selectSubjectID = String()
    
    var sStudentNames = [String]()
    var sStudentIDs = [String]()
    var sStudentImageURls = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        getClassAndSession()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! SubjectReportTableViewController
        DestinationViewController.sUserNames = self.sStudentNames
        DestinationViewController.sUserImgUrl = self.sStudentImageURls
        DestinationViewController.sUserIDs = self.sStudentIDs
    }
    
    @IBAction func onClick_selectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClassDrop
        dropDown.dataSource = self.sClasses
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_select.setTitle(item, for: .normal)
            self.selectedClass = index
            self.btn_selectSection.setTitle("Select Section", for: .normal)
        }
        dropDown.width = view_selectClassDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectSection(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectSectionDrop
        dropDown.dataSource = self.sSessions[selectedClass]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectSection.setTitle(item, for: .normal)
            self.selectedSectionID = index
            self.btn_selectSubject.setTitle("Select Subject", for: .normal)
            self.getSubject()
        }
        dropDown.width = view_selectSectionDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectSubject(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectSubjectDrop
        dropDown.dataSource = self.sSubjectNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectSubject.setTitle(item, for: .normal)
            self.selectSubjectID = self.sSubjectIDs[index]
            self.getStudentsInfo()
        }
        dropDown.width = view_selectSubjectDrop.frame.width
        dropDown.show()
    }
    
    func buildUI(){
        view_selectClass.layer.borderWidth = 1
        view_selectClass.layer.cornerRadius = 5
        view_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectSection.layer.borderWidth = 1
        view_selectSection.layer.cornerRadius = 5
        view_selectSection.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectSubject.layer.borderWidth = 1
        view_selectSubject.layer.cornerRadius = 5
        view_selectSubject.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_top.layer.borderWidth = 1
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func getClassAndSession(){
        self.sClassIDs.removeAll()
        self.sClasses.removeAll()
        self.sSessions.removeAll()
        self.sSessionIDs.removeAll()
        
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_class_by_subject_teacher")!
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
                        self.sClasses.append(sClassName)
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
                        self.sSessions.append(tempSeesions)
                        self.sSessionIDs.append(tempSessionIds)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getSubject(){
        if (selectedSectionID < 0 || selectedClass < 0){
            return
        }
        if (self.sSessionIDs.count < 1){
            return
        }
        self.sSubjectIDs.removeAll()
        self.sSubjectNames.removeAll()
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let section_id = self.sSessionIDs[selectedClass][selectedSectionID]
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_subject_by_teach_teacher")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&section_id=\(section_id)"
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
                    let subjects = parseData["subjects"] as! [[String:Any]]
                    for subject in subjects {
                        let subject_name = subject["name"] as! String
                        let subject_id = subject["subject_id"] as! String
                        self.sSubjectNames.append(subject_name)
                        self.sSubjectIDs.append(subject_id)
                    
                    }
                }
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
    
    func getStudentsInfo(){
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let class_id = self.sClassIDs[selectedClass]
        let section_id = self.sSessionIDs[selectedClass][selectedSectionID]
        
        GlobalConst.glb_classID = class_id
        GlobalConst.glb_sectionID = section_id
        GlobalConst.glb_subjectID = self.selectSubjectID
        
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_students_by_class_section")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&class_id=\(class_id)&section_id=\(section_id)"
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
                    let students = parseData["students"] as! [[String:Any]]
                    for student in students {
                        let sStudentName = student["name"] as? String
                        let sStudentLName = student["lname"] as? String
                        let sStudentFullName: String!
                        sStudentFullName = "\(sStudentName ?? "") \(sStudentLName ?? "")"
                        self.sStudentNames.append(sStudentFullName)
                        let sStudentID = student["student_id"] as? String
                        self.sStudentIDs.append(sStudentID!)
                        let sStudentImgURL = student["stud_image"] as? String
                        if (sStudentImgURL == nil){
                            self.sStudentImageURls.append("")
                        } else {
                            self.sStudentImageURls.append(sStudentImgURL!)
                        }
                    }
                    DispatchQueue.main.async(execute: {
                        self.performSegue(withIdentifier: "gotoSubjectTableView", sender: self)
                        self.processDialog.dismiss(animated: true, completion: nil)
                    })
                }
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
