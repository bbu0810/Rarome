//
//  Term_WiseViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/26/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Foundation
import DropDown
class Term_WiseViewController: UIViewController, IndicatorInfoProvider {
  
    
    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var btn_selectClass: UIButton!
    @IBOutlet weak var btn_selectFeeType: UIButton!
    @IBOutlet weak var btn_selectTerm: UIButton!
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var view_selectFeeType: UIView!
    @IBOutlet weak var view_selectTerm: UIView!
    
    var classNames = [String]()
    var classID = [String]()
    var feeType = [String]()
    var terms = [String]()
    
    var selectClass: Int!
    var selectFeeType: Int!
    var selectTerm: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildinUI()
        self.getClass()
        selectClass = -1
        selectFeeType = -1
        selectTerm = -1
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func onClick_selectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClass
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectClass.setTitle(item, for: .normal)
            self.selectClass = index
            self.btn_selectFeeType.setTitle("Select Fee Type", for: .normal)
            self.getFeeType()
        }
        dropDown.width = btn_selectClass.frame.width
        dropDown.show()
        
        
    }
    
    @IBAction func onClick_selectFeeType(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectFeeType
        dropDown.dataSource = self.feeType
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectFeeType.setTitle(item, for: UIControlState.normal)
            self.selectFeeType = index
            self.getTerms()
        }
        dropDown.width = btn_selectFeeType.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectTerm(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectFeeType
        dropDown.dataSource = self.feeType
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectTerm.setTitle(item, for: UIControlState.normal)
            self.selectTerm = index
        }
        dropDown.width = btn_selectFeeType.frame.width
        dropDown.show()
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Term-Wise")
    }

    
    func buildinUI(){
        btn_selectClass.layer.borderWidth = 1
        btn_selectClass.layer.cornerRadius = 5
        btn_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        btn_selectFeeType.layer.borderWidth = 1
        btn_selectFeeType.layer.cornerRadius = 5
        btn_selectFeeType.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        btn_selectTerm.layer.borderWidth = 1
        btn_selectTerm.layer.cornerRadius = 5
        btn_selectTerm.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_top.layer.borderWidth = 1
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
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
    
    func getFeeType(){
        if selectClass < 0 {
            return
        }
        self.feeType.removeAll()
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
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
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
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
    
    func getTerms(){
        if selectClass < 0 {
            return
        }
        if selectFeeType < 0 {
            return
        }
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let class_id: String = self.classID[self.selectClass]
        let fee_type: String = self.feeType[self.selectFeeType]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_class_wise_terms")!
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
                    let sResult = parseData["records"] as! [[String:AnyObject]]
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
}
