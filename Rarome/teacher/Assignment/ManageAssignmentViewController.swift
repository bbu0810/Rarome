//
//  ManageAssignmentViewController.swift
//  Rarome
//
//  Created by AntonDream on 10/6/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown
class ManageAssignmentViewController: UIViewController {
    
    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var viewSelectClass: UIView!
    @IBOutlet weak var btnSelectClass: UIButton!
    @IBOutlet weak var viewSelectClassDrop: UIView!
    
    @IBOutlet weak var viewSelectSection: UIView!
    @IBOutlet weak var btnSelectSection: UIButton!
    @IBOutlet weak var viewSelectSectionDrop: UIView!
    
    @IBOutlet weak var viewSelectSubject: UIView!
    @IBOutlet weak var btnSelectSubject: UIButton!
    @IBOutlet weak var viewSelectSubjectDrop: UIView!
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    
    var sClassIDs = [String]()
    var sClassNames = [String]()
    var sSectionIDs = [[String]]()
    var sSectionNames = [[String]]()
    var sSubjectName = [String]()
    var sSubjectIDs = [String]()
    
    var indexOfSelectedClass = -1
    var indexOfSelectedSection = -1
    var indexOfSelectSubject = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
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
            self.btnSelectSubject.setTitle("Select Subject", for: .normal)
            self.getSubject()
        }
        dropDown.width = viewSelectSectionDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClickBtnSelectSubject(_ sender: Any, forEvent event: UIEvent) {
    }
    
    @IBAction func onClickBtnManageAssignment(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    func getSubject(){
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let subject_id = self.sSectionIDs[indexOfSelectedClass][indexOfSelectedSection]
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_subject_by_teach_teacher")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&subject_id=\(subject_id)"
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
                    let subjects = parseData["subjects"] as! [[String:Any]]
                    for subject in subjects {
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
    
    
    func buildUI(){
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectClass.layer.borderWidth = 1
        viewSelectClass.layer.cornerRadius = 5
        viewSelectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectSection.layer.borderWidth = 1
        viewSelectSection.layer.cornerRadius = 5
        viewSelectSection.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        viewSelectSubject.layer.borderWidth = 1
        viewSelectSubject.layer.cornerRadius = 5
        viewSelectSubject.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
}

