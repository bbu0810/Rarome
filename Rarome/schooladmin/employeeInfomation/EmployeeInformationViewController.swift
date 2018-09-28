//
//  EmployeeInformationViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/6/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown

class EmployeeInformationViewController: UIViewController {
    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var btn_selectDepartment: UIButton!
    @IBOutlet weak var view_selectDepartment: UIView!
    
    var sDepartmentNames = [String]()
    var sDepartmentIDs = [String]()
    var iSelectedNumber: Int!
    
    var sEmployeeNames = [String]()
    var sEmployeeFirstName = [String]()
    var sEmployeeLastName = [String]()
    var sEmployeeIDs = [String]()
    
    var sEmail = [String]()
    var sDateOfBirthday = [String]()
    var sGender = [String]()
    var sYearsOfExp = [String]()
    var sRoleName = [String]()
    var sDateOfJoning = [String]()
    var sPhoneNumber = [String]()
    var sSalar = [String]()
    var sLeave = [String]()
    var sHomeNumber = [String]()
    var sAddress = [String]()
    var sBankName = [String]()
    var sBankRecordName = [String]()
    var sAccounttype = [String]()
    var sAccountNo = [String]()
    var sBankAccountRef = [String]()
    var sStatus = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iSelectedNumber = -1
        getDepartments()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var DestinationViewController = segue.destination as! DepartmentTableTableViewController
        DestinationViewController.sEmployeeNames = self.sEmployeeNames
        DestinationViewController.sEmployeeFirstName = self.sEmployeeFirstName
        DestinationViewController.sEmployeeLastName = self.sEmployeeLastName
        DestinationViewController.sEmployeeIDs = self.sEmployeeIDs
        DestinationViewController.sEmail = self.sEmail
        DestinationViewController.sDateOfBirthday = self.sDateOfBirthday
        DestinationViewController.sGender = self.sGender
        DestinationViewController.sYearsOfExp = self.sYearsOfExp
        DestinationViewController.sRoleName = self.sRoleName
        DestinationViewController.sDateOfJoning = self.sDateOfJoning
        DestinationViewController.sPhoneNumber = self.sPhoneNumber
        DestinationViewController.sSalar = self.sSalar
        DestinationViewController.sLeave = self.sLeave
        DestinationViewController.sHomeNumber = self.sHomeNumber
        DestinationViewController.sAddress = self.sAddress
        DestinationViewController.sBankName = self.sBankName
        DestinationViewController.sBankRecordName = self.sBankRecordName
        DestinationViewController.sAccounttype = self.sAccounttype
        DestinationViewController.sAccountNo = self.sAccountNo
        DestinationViewController.sBankAccountRef = self.sBankAccountRef
        DestinationViewController.sStatus = self.sStatus
        
    }
    
    @IBAction func onClick_selectDepartment(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectDepartment
        dropDown.dataSource = self.sDepartmentNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.iSelectedNumber = index
            GlobalConst.glb_sDepartmentID = GlobalConst.glb_sDeparmentIDs[index]
            self.getSelectedDepartmentInfo()
        }
        dropDown.width = btn_selectDepartment.frame.width
        dropDown.show()
    }
    
    func getDepartments(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_department_list")!
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
                    let sResults = parseData["department_list"] as! [[String:AnyObject]]
                    for result in sResults{
                        let departmentName = result["department_name"] as? String
                        self.sDepartmentNames.append(departmentName!)
                        let departmentID = result["id"] as? String
                        self.sDepartmentIDs.append(departmentID!)
                    }
                    GlobalConst.glb_sDepartmentNames = self.sDepartmentNames
                    GlobalConst.glb_sDeparmentIDs = self.sDepartmentIDs
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getSelectedDepartmentInfo(){
        if iSelectedNumber < 0 {
            return
        }
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let departmentID: String = sDepartmentIDs[iSelectedNumber]        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_all_employee_department_wise")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&department_id=\(departmentID)"
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
                    let sResults = parseData["employee_list"] as! [[String:AnyObject]]
                    for result in sResults{
                        let sEmployeeFName = result["fname"] as? String
                        self.sEmployeeFirstName.append(sEmployeeFName!)
                        let sEmployeeLName = result["lname"] as? String
                        self.sEmployeeLastName.append(sEmployeeLName!)
                        let sMotherFullName: String!
                        sMotherFullName = "\(sEmployeeFName ?? "") \(sEmployeeLName ?? "")"
                        self.sEmployeeNames.append(sMotherFullName!)
                        let departmentID = result["employee_id"] as? String
                        self.sEmployeeIDs.append(departmentID!)
                        let email = result["email"] as? String
                        self.sEmail.append(email!)
                        let dateOfBirthday = result["dob"] as? String
                        self.sDateOfBirthday.append(dateOfBirthday!)
                        let gender = result["gender"] as? String
                        self.sGender.append(gender!)
                        let yearOfExp = result["year_of_exp"] as? String
                        self.sYearsOfExp.append(yearOfExp!)
                        let dateOfJoining = result["date_of_joining"] as? String
                        if dateOfJoining == nil{
                            self.sDateOfJoning.append("")
                        }else{
                            self.sDateOfJoning.append(dateOfJoining!)                            
                        }
                        let phoneNumber = result["phone_number"] as? String
                        self.sPhoneNumber.append(phoneNumber!)
                        let salary = result["emp_salary"] as? String
                        self.sSalar.append(salary!)
                        let status = result["is_active"] as? String
                        if status == "1"{
                            self.sStatus.append("Active")
                        } else {
                            self.sStatus.append("UnActive")
                        }
                        let leave = result["emp_leaves"] as? String
                        if leave == nil {
                            self.sLeave.append("")
                        } else {
                            self.sLeave.append(leave!)
                        }
                        let homeNumber = result["home_no"] as? String
                        self.sHomeNumber.append(homeNumber!)
                        let address = result["address"] as? String
                        if address == nil {
                            self.sAddress.append("")
                        } else {
                            self.sAddress.append(address!)                            
                        }
                        let rolName = result["role_name"] as? String
                        if rolName == nil {
                            self.sRoleName.append("")
                        } else {
                            self.sRoleName.append(rolName!)
                        }
                        let bankName = result["bank_name"] as? String
                        self.sBankName.append(bankName!)
                        let bankRecordName = result["bank_record_name"] as? String
                        self.sBankRecordName.append(bankRecordName!)
                        let accountNumber = result["bank_account_number"] as? String
                        self.sAccountNo.append(accountNumber!)
                        let bankAccountRef = result["bank_account_ref"] as? String
                        self.sBankAccountRef.append(bankAccountRef!)
                    }
                    DispatchQueue.main.async(execute: {
                        GlobalConst.glb_sEmployeeIDs = self.sEmployeeIDs
                        self.performSegue(withIdentifier: "gotoDepartmentTable", sender: self)
                    })
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    func buildUI(){
        btn_selectDepartment.layer.borderWidth = 1
        btn_selectDepartment.layer.cornerRadius = 5
        btn_selectDepartment.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_top.layer.borderWidth = 1
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
}
