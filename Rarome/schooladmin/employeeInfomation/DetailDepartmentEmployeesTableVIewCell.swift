//
//  DetailDepartmentEmployeesTableVIewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/6/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//  gotoDetailDepartmentEmployeesTableViewCell

import Foundation
import UIKit
class DetailDepartmentEmployeesTableVIewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var view_cell: UIView!
    
    var iNumber: Int?
        
    @IBAction func onClick_detail(_ sender: UIButton, forEvent event: UIEvent) {
        GlobalConst.glb_selectedID = iNumber
    }
    
    @IBAction func onClick_edit(_ sender: UIButton, forEvent event: UIEvent) {
        GlobalConst.glb_selectedID = iNumber
    }
    
    @IBAction func onClick_delete(_ sender: UIButton, forEvent event: UIEvent) {
        deleteEmployee()
    }
    
    func deleteEmployee(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let employeeId: String = GlobalConst.glb_sEmployeeIDs[iNumber!]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/delete_employee")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&employee_id=\(employeeId)"
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
                    self.showResult(result: sMessage)                
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func showResult(result: String){
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: "Result", message: result, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
}
