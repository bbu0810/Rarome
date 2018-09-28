//
//  AttendanceReportViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/18/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown
import DatePickerDialog
class AttendanceReportViewController: UIViewController {

    var sClassIDs = [String]()
    var sClassNames = [String]()
    var sSectionIDs = [[String]]()
    var sSectionNames = [[String]]()
    let months = ["July", "August", "September", "October", "November", "December", "January", "Feburary", "March", "April", "May", "June"]
    let daysPerMonth = [31, 31, 30, 31, 30, 31, 31, 28, 31, 30, 31, 30]
    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var btn_selectClass: UIButton!
    @IBOutlet weak var view_selectClassDrop: UIView!
    
    @IBOutlet weak var view_selectSection: UIView!
    @IBOutlet weak var btn_selectSection: UIButton!
    @IBOutlet weak var view_selectSectionDrop: UIView!
    
    @IBOutlet weak var view_selectDate: UIView!
    @IBOutlet weak var btn_selectDate: UIButton!
    @IBOutlet weak var view_selectMonthsDrop: UIView!
    
    @IBOutlet weak var btn_ManageAttendance: UIButton!
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    
    var selectedClassIndex = -1
    var selectSectionIndex = -1
    var selectMonthIndex = -1
    
    var sStudentNames = [String]()
    var sStudentIds = [String]()
    var sStudentImgUrl = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewcontroller = segue.destination as! AttendanceReportManageViewController
        DestinationViewcontroller.sStudentNames = self.sStudentNames
        DestinationViewcontroller.sStudentIds = self.sStudentIds
        DestinationViewcontroller.sStudentImgUrl = self.sStudentImgUrl
        let sClassName = sClassNames[selectedClassIndex]
        let sSectionsName = sSectionNames[selectedClassIndex][selectSectionIndex]
        let sMonthname = months[selectMonthIndex]
        var sTitle = "Attendance For \(sClassName)- \(sSectionsName) fot the month of \(sMonthname)"
        DestinationViewcontroller.sTitle = sTitle
    }
    
    @IBAction func onClick_btnSelectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClassDrop
        dropDown.dataSource = self.sClassNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectClass.setTitle(item, for: .normal)
            self.selectedClassIndex = index
            self.btn_selectSection.setTitle("Select Section", for: .normal)
        }
        dropDown.width = view_selectClassDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_btnSelectSection(_ sender: UIButton, forEvent event: UIEvent) {
        if selectedClassIndex < 0 {
            return
        }
        let dropDown = DropDown()
        dropDown.anchorView = view_selectSectionDrop
        dropDown.dataSource = self.sSectionNames[selectedClassIndex]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectSection.setTitle(item, for: .normal)
            self.selectSectionIndex = index
            self.btn_selectDate.setTitle("Select Month", for: .normal)
        }
        dropDown.width = view_selectSectionDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectDate(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectMonthsDrop
        dropDown.dataSource = self.months
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectDate.setTitle(item, for: .normal)
            self.selectMonthIndex = index
        }
        dropDown.width = view_selectMonthsDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_btnManageAttendance(_ sender: UIButton, forEvent event: UIEvent) {
        getStudentsByClassAndSection()
    }
    
    func buildUI(){
        view_selectClass.layer.borderWidth = 1
        view_selectClass.layer.cornerRadius = 5
        view_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectSection.layer.borderWidth = 1
        view_selectSection.layer.cornerRadius = 5
        view_selectSection.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectDate.layer.borderWidth = 1
        view_selectDate.layer.cornerRadius = 5
        view_selectDate.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
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
    
    func getStudentsByClassAndSection(){
        if selectedClassIndex < 0 || selectSectionIndex < 0 {
            return
        }
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let class_id = self.sClassIDs[selectedClassIndex]
        let section_id = self.sSectionIDs[selectedClassIndex][selectSectionIndex]
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_students_by_class_section")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var sDeviceToken: String = ""
        var iDeviceID: String = (UIDevice.current.identifierForVendor?.uuidString)!
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
                        self.performSegue(withIdentifier: "gotoAttendanceReportViewController", sender: self)
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
