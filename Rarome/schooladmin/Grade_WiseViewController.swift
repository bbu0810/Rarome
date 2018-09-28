//
//  Grade_WiseViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/26/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Foundation
import DropDown
class Grade_WiseViewController: UIViewController, IndicatorInfoProvider, UITableViewDataSource {
    
    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var layout_top: UIStackView!
    @IBOutlet weak var btn_selectClass: UIButton!
    @IBOutlet weak var btn_selectFeeType: UIButton!
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var view_slect_fee_type: UIView!
    @IBOutlet weak var table_class_member: UITableView!
    @IBOutlet weak var lbl_classTotalPaid: UILabel!
    @IBOutlet weak var lbl_classTotalDue: UILabel!
    @IBOutlet weak var lbl_paidValue: UILabel!
    @IBOutlet weak var lbl_budValue: UILabel!
    
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    
    var classNames = [String]()
    var classID = [String]()
    var feeType = [String]()
    var studentName = [String]()
    var selectClass: Int!
    var selectFeeType: Int!
    var sTotalPaid: Int!
    var sTotalDue: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildinUI()
        self.getClass()
        selectClass = -1
        selectFeeType = -1
    }

    @IBAction func onTest(_ sender: UIButton) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClass
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectClass.setTitle(item, for: .normal)
            self.selectClass = index
        }
        dropDown.width = btn_selectClass.frame.width
        dropDown.show()
        self.getFeeType()
        self.btn_selectFeeType.setTitle("Select Fee Type", for: .normal)
    }
    
    @IBAction func onClick_feeType(_ sender: Any) {
        let dropDown = DropDown()
        dropDown.anchorView = view_slect_fee_type
        dropDown.dataSource = self.feeType
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectFeeType.setTitle(item, for: UIControlState.normal)
            self.selectFeeType = index
            self.getClassWiseFeeDuo()
        }
        dropDown.width = btn_selectFeeType.frame.width
        dropDown.show()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")!
        let text = studentName[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentName.count
    }
    
    
    func getClass(){
        let userid: String = sUserId
        let usertype: String = sUserType
        let schoolid: String = sSchoolID
        let runing_year: String = sRunging_year
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
    
    func getFeeType(){
        self.feeType.removeAll()
        let userid: String = sUserId
        let usertype: String = sUserType
        let schoolid: String = sSchoolID
        let runing_year: String = sRunging_year
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_fee_types")!
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
                    let sResult = parseData["types"] as! [[String:AnyObject]]
                    for result in sResult {
                        if let sFeeType = result["name"] as? String {
                            self.feeType.append(sFeeType)
                        }
                    }
                }
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
        btn_selectFeeType.layer.borderWidth = 1
        btn_selectFeeType.layer.cornerRadius = 5
        btn_selectFeeType.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_top.layer.borderWidth = 1
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Grade-Wise")
    }
    
    func getClassWiseFeeDuo(){
        if selectClass < 0 {
            return
        }
        if selectFeeType < 0 {
            return
        }
        self.studentName.removeAll()
        let userid: String = sUserId
        let usertype: String = sUserType
        let schoolid: String = sSchoolID
        let runing_year: String = sRunging_year
        let class_id: String = classID[selectClass]
        let fee_type: String = feeType[selectFeeType]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/class_wise_dues_fees")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&class_id=\(class_id)&fee_type=\(fee_type)"
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
                    self.sTotalPaid = parseData["class_total_paid"] as! Int
                    self.sTotalDue = parseData["class_total_due"] as! Int
                    let sResult = parseData["students"] as! [[String:AnyObject]]
                    for result in sResult {
                        let sStudentName = result["student_name"] as? String
                        self.studentName.append(sStudentName!)
                    }
                }
                self.resultShow()
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func resultShow(){
        DispatchQueue.main.async(execute: {
            self.table_class_member.dataSource = self
            self.table_class_member.reloadData()
            self.lbl_classTotalPaid.text = "Class Total Paid"
            self.lbl_classTotalDue.text = "Class Total Due"
            self.lbl_paidValue.text = String(self.sTotalPaid)
            self.lbl_budValue.text = String(self.sTotalDue)
        })
    }
}


