//
//  VerifyAssignmentViewController.swift
//  Rarome
//
//  Created by AntonDream on 10/5/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown
class VerifyAssignmentViewController: UIViewController {

    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var viewSelectClass_top: UIView!
    @IBOutlet weak var btnSelectClass: UIButton!
    @IBOutlet weak var viewSelectClassDrop: UIView!
    
    @IBOutlet weak var viewSelectSection_top: UIView!
    @IBOutlet weak var btnSelectSection: UIButton!
    @IBOutlet weak var viewSelectSectionDrop: UIView!
    
    @IBOutlet weak var viewSelectStudent_top: UIView!
    @IBOutlet weak var btnSelectStudent: UIButton!
    @IBOutlet weak var viewSelectStudentDrop: UIView!
  
    @IBOutlet weak var viewSelectSubject_top: UIView!
    @IBOutlet weak var btnSelectSubject: UIButton!
    @IBOutlet weak var viewSelectSubjectDrop: UIView!
    
    @IBOutlet weak var viewSelectTopic: UIView!
    @IBOutlet weak var btnSelectTopic: UIButton!
    @IBOutlet weak var viewSelectTopicDrop: UIView!
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    
    var sClassIDs = [String]()
    var sClassNames = [String]()
    var sSectionIDs = [[String]]()
    var sSectionNames = [[String]]()
    var sStudentNames = [String]()
    var sStudentIds = [String]()
    var sStudentImgUrl = [String]()
    var sSubjectNames = [String]()
    var sSubjectIDs = [String]()
    var sTopicNames = [String]()
    var sTopicIDs = [String]()
    
    var indexOfSelectedClass = -1
    var indexOfSelectedSection = -1
    var indexOfSelectedStudent = -1
    var indexOfSelectedSubject = -1
    var indexOfSelectedTopic = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        initParams()
        getClassAndSection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClickBtnSelectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = viewSelectClassDrop
        dropDown.dataSource = self.sClassNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectClass.setTitle(item, for: .normal)
            self.indexOfSelectedClass = index
            self.btnSelectSection.setTitle("Select Section", for: .normal)
        }
        dropDown.width = viewSelectClassDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClickBtnSelectSection(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = viewSelectSectionDrop
        dropDown.dataSource = self.sSectionNames[indexOfSelectedClass]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectSection.setTitle(item, for: .normal)
            self.indexOfSelectedSection = index
            self.btnSelectStudent.setTitle("Select Student", for: .normal)
            self.getStudent()
        }
        dropDown.width = viewSelectSectionDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClickBtnSelectStudent(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = viewSelectStudentDrop
        dropDown.dataSource = self.sStudentNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectStudent.setTitle(item, for: .normal)
            self.indexOfSelectedStudent = index
            self.btnSelectSubject.setTitle("Select Subject", for: .normal)
            self.getSubject()
        }
        dropDown.width = viewSelectStudentDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClickBtnSelectSubject(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = viewSelectSubjectDrop
        dropDown.dataSource = self.sSubjectNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectSubject.setTitle(item, for: .normal)
            self.indexOfSelectedSubject = index
            self.btnSelectTopic.setTitle("Select Topic", for: .normal)
            self.getTopic()
        }
        dropDown.width = viewSelectSubjectDrop.frame.width
        dropDown.show()
    }
   
    @IBAction func onClickBtnTopic(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = viewSelectTopicDrop
        dropDown.dataSource = self.sTopicNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btnSelectTopic.setTitle(item, for: .normal)
            self.indexOfSelectedTopic = index
        }
        dropDown.width = viewSelectTopicDrop.frame.width
        dropDown.show()
    }
    
    func getTopic(){
        if indexOfSelectedClass < 0 || indexOfSelectedSection < 0 || indexOfSelectedStudent < 0 || indexOfSelectedSubject < 0 {
            return
        }
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let class_id = self.sClassIDs[indexOfSelectedClass]
        let section_id = self.sSectionIDs[indexOfSelectedClass][indexOfSelectedSection]
        let subject_id = self.sSubjectIDs[indexOfSelectedSubject]
        let student_id = self.sStudentIds[indexOfSelectedStudent]
        
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_assignemnt_topic")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&class_id=\(class_id)&section_id=\(section_id)&subject_id=\(subject_id)&student_id=\(student_id))"
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
                    let topics = parseData["topic_list"] as! [[String:Any]]
                    for topic in topics {
                        let topic_id = topic["topic_id"] as? String
                        self.sTopicIDs.append(topic_id!)
                        let topic_name = topic["topic_name"] as? String
                        self.sTopicNames.append(topic_name!)
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
    
    func getSubject(){
        if indexOfSelectedClass < 0 || indexOfSelectedSection < 0 || indexOfSelectedStudent < 0{
            return
        }
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let section_id = self.sSectionIDs[indexOfSelectedClass][indexOfSelectedSection]
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_subject_by_teach_teacher")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&section_id=\(section_id)"
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
                    let subjects = parseData["subjects"] as? [[String: Any]]
                    for subject in subjects! {
                        let subjectName = subject["name"] as? String
                        self.sSubjectNames.append(subjectName!)
                        let subjectID = subject["subject_id"] as? String
                        self.sSubjectIDs.append(subjectID!)
                    }
                    DispatchQueue.main.async(execute: {
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
    
    func getClassAndSection(){
        self.sClassIDs.removeAll()
        self.sClassNames.removeAll()
        self.sSectionNames.removeAll()
        self.sSectionIDs.removeAll()
        
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
                        self.sSectionIDs.append(tempSessionIds)
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
    
    func getStudent(){
        if indexOfSelectedClass < 0 || indexOfSelectedSection < 0 {
            return
        }
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let class_id = self.sClassIDs[indexOfSelectedClass]
        let section_id = self.sSectionIDs[indexOfSelectedClass][indexOfSelectedSection]
        
        present(processDialog, animated: true, completion: nil)
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
                    let students = parseData["students"] as? [[String: Any]]
                    for student in students! {
                        let sStudentName = student["name"] as? String
                        let sStudentLName = student["lname"] as? String
                        let sStudentFullName: String!
                        sStudentFullName = "\(sStudentName ?? "") \(sStudentLName ?? "")"
                        self.sStudentNames.append(sStudentFullName)
                        let studentId = student["student_id"] as! String
                        self.sStudentIds.append(studentId)
                        let studentImgUrl = student["stud_image"] as? String ?? ""
                        self.sStudentImgUrl.append(studentImgUrl)
                    }
                    DispatchQueue.main.async(execute: {
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
    
    func buildUI(){
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectClass_top.layer.borderWidth = 1
        viewSelectClass_top.layer.cornerRadius = 5
        viewSelectClass_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectSection_top.layer.borderWidth = 1
        viewSelectSection_top.layer.cornerRadius = 5
        viewSelectSection_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectStudent_top.layer.borderWidth = 1
        viewSelectStudent_top.layer.cornerRadius = 5
        viewSelectStudent_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectSubject_top.layer.borderWidth = 1
        viewSelectSubject_top.layer.cornerRadius = 5
        viewSelectSubject_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectTopic.layer.borderWidth = 1
        viewSelectTopic.layer.cornerRadius = 5
        viewSelectTopic.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }

    func initParams(){
           sClassIDs.removeAll()
           sClassNames.removeAll()
           sSectionIDs.removeAll()
           sSectionNames.removeAll()
           sStudentNames.removeAll()
           sStudentIds.removeAll()
           sStudentImgUrl.removeAll()
           sSubjectNames.removeAll()
           sSubjectIDs.removeAll()
           sTopicNames.removeAll()
           sTopicIDs.removeAll()
        
           indexOfSelectedClass = -1
           indexOfSelectedSection = -1
           indexOfSelectedStudent = -1
           indexOfSelectedSubject = -1
           indexOfSelectedTopic = -1
    }
}
