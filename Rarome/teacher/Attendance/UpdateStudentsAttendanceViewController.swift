//
//  UpdateStudentsAttendanceViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/15/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
var strButtonStatus = [String]()
var imgsOfButton = [UIImage]()
class UpdateStudentsAttendanceViewController: UIViewController, UITableViewDataSource{

    let processDialog = MyProcessDialogViewController(message: "Loading...")
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var edt_RFID: UITextField!
    @IBOutlet weak var btn_validate: UIButton!
    @IBOutlet weak var tbl_students: UITableView!

    var sClassID = String()
    var sSectionID = String()
    var sDate = String()
    
    var sStudentsName = [String]()
    var sStudentIds = [String]()
    var sStudentImgUrl = [String]()
    var sStudentAttendaceStatu = [String]()
    var sTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        strButtonStatus.removeAll()
        imgsOfButton.removeAll()
        getFromServer()
        lbl_title.text = sTitle
        tbl_students.frame.size.height = CGFloat(70 * sStudentsName.count)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    @IBAction func onClick_btnValidate(_ sender: UIButton, forEvent event: UIEvent) {
        updateToServer()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoManageAttendanceTableCell", for: indexPath) as! ManageAttendanceTableViewCell
        cell.lbl_userName.text = sStudentsName[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        cell.btn_absent.setImage(imgsOfButton[indexPath.row], for: .normal)
        cell.index = indexPath.row
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sStudentsName.count
    }
    
    func getFromServer(){
        var Param : [String:Any] = [:]
        Param["school_id"] = GlobalConst.glb_sSchoolID!
        Param["running_year"] = GlobalConst.glb_sRunning_year!
        Param["user_type"] = GlobalConst.glb_sUserType!
        Param["user_id"] = GlobalConst.glb_sUserId!
        Param["class_id"] = self.sClassID
        Param["section_id"] = self.sSectionID
        Param["date"] = self.sDate
        var postString = String()
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: Param,
            options: []) {
            postString = String(data: theJSONData, encoding: .ascii)!
        }
//        present(processDialog, animated: true, completion: nil)
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/native_get_attendance_student_list")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
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
                    let sAttendances = parseData["attendance"] as! [[String:Any]]
                    for sAttendance in sAttendances {
                        let attendanceStatu = sAttendance["status"] as! String
                        strButtonStatus.append(attendanceStatu)
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                    for index in 0..<self.sStudentsName.count{
                        if strButtonStatus[index] == "2"{
                            let img = UIImage(named: "btn_absentUnselect")
                            imgsOfButton.append(img!)
                        } else {
                            let img = UIImage(named: "btn_presentSelected")
                            imgsOfButton.append(img!)
                        }
                    }
                    self.tbl_students.dataSource = self
                    self.tbl_students.reloadData()
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
    
    func updateToServer(){
        var Param : [String:Any] = [:]
        var atten = [Any]()
        
        for index in 0..<strButtonStatus.count {
            var dicStudent : [String : String] = [:]
            dicStudent["student_id"] = self.sStudentIds[index]
            dicStudent["status"] = strButtonStatus[index]
            atten.append(dicStudent)
        }
        Param["school_id"] = GlobalConst.glb_sSchoolID!
        Param["running_year"] = GlobalConst.glb_sRunning_year!
        Param["user_type"] = GlobalConst.glb_sUserType!
        Param["user_id"] = GlobalConst.glb_sUserId!
        Param["class_id"] = self.sClassID
        Param["section_id"] = self.sSectionID
        Param["date"] = self.sDate
        Param["atten"] = atten
        var postString = String()
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: Param,
            options: []) {
            postString = String(data: theJSONData, encoding: .ascii)!
        }
        
        present(processDialog, animated: true, completion: nil)
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/native_update_manual_attendance")!
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

extension UpdateStudentsAttendanceViewController: ManageAttendanceTableViewCellDelegate{
    func didTapButton(index: Int) {
        if strButtonStatus[index] == "2" {
            strButtonStatus[index] = "1"
            let img = UIImage(named: "btn_presentSelected")
            imgsOfButton[index] = img!
        } else {
            strButtonStatus[index] = "2"
            let img = UIImage(named: "btn_absentUnselect")
            imgsOfButton[index] = img!
        }
        tbl_students.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .none)
    }
}
