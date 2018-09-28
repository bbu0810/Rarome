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
    var semployeeIDs = [String]()
    
    
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
        DestinationViewController.semployeeIDs = self.semployeeIDs
    }
    
    @IBAction func onClick_selectDepartment(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectDepartment
        dropDown.dataSource = self.sDepartmentNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.iSelectedNumber = index
            self.getSelectedDepartmentInfo()
            self.performSegue(withIdentifier: "gotoDepartmentTable", sender: self)
            
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
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_role_list_by_department_wise")!
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
                    let sResults = parseData["department_list"] as! [[String:AnyObject]]
                    for result in sResults{
                        let departmentName = result["department_name"] as? String
                        self.sDepartmentNames.append(departmentName!)
                        let departmentID = result["id"] as? String
                        self.sDepartmentIDs.append(departmentID!)
                    }
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
