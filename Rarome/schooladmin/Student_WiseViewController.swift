//
//  Student_WiseViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/26/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Foundation
import DropDown
class Student_WiseViewController: UIViewController, IndicatorInfoProvider, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var btn_selectClass: UIButton!
    @IBOutlet weak var btn_selectStudent: UIButton!
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var view_selectStudent: UIView!
    @IBOutlet weak var view_selectClassTop: UIView!
    @IBOutlet weak var ivew_selectStudentTop: UIView!
    
    @IBOutlet weak var view_top1: UIView!
    @IBOutlet weak var lbl_titleEnrollCode: UILabel!
    @IBOutlet weak var lbl_enrollCode: UILabel!
    @IBOutlet weak var lbl_titleStudentName: UILabel!
    @IBOutlet weak var lbl_studentName: UILabel!
    @IBOutlet weak var lbl_titleGrade: UILabel!
    @IBOutlet weak var lbl_grade: UILabel!
    @IBOutlet weak var lbl_titleDateOfAdmission: UILabel!
    @IBOutlet weak var lbl_dateOfAdmission: UILabel!
    
    @IBOutlet weak var tbl_studentWiseFee: UITableView!
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    
    var classNames = [String]()
    var classID = [String]()
    var studentName = [String]()
    var studentID = [String]()
    var sEnrollCode: String!
    var sGrade: String!
    var sDataOfAdmission: String!
//    var sSchoolFees: String!
//    var sHostelFees: String!
//    var sTransportFees: String!
//    var sMessFees: String!
   
    var selectClass: Int!
    var selectStudent: Int!
    
    var sSchoolFee_termName = [String]()
    var sSchoolFee_label = [String]()
    var sSchoolFee_termAmount = [String]()
    var sSchoolFee_scholarship = [Int]()
    var sSchoolFee_Concession = [Int]()
    var sSchoolFee_Fine = [Int]()
    var sSchoolFee_total = [Int]()
    var sSchoolFee_totalPaid = [Int]()
    var sSchoolFee_netDue = [Int]()
    
    var sHostelFee_termName = [String]()
    var sHostelFee_label = [String]()
    var sHostelFee_termAmount = [String]()
    var sHostelFee_scholarship = [Int]()
    var sHostelFee_concession = [Int]()
    var sHostelFee_fine = [Int]()
    var sHostelFee_total = [Int]()
    var sHostelFee_totalPaid = [Int]()
    var sHostelFee_netDue = [Int]()
    
    var sTransportFee_termName = [String]()
    var sTransportFee_label = [String]()
    var sTransportFee_termAmount = [String]()
    var sTransportFee_scholarship = [Int]()
    var sTransportFee_concession = [Int]()
    var sTransportFee_fine = [Int]()
    var sTransportFee_total = [Int]()
    var sTransportFee_totalPaid = [Int]()
    var sTransportFee_netDue = [Int]()
    
    var sMessFee_termName = [String]()
    var sMessFee_label = [String]()
    var sMessFee_termAmount = [String]()
    var sMessFee_scholarship = [Int]()
    var sMessFee_concession = [Int]()
    var sMessFee_fine = [Int]()
    var sMessFee_total = [Int]()
    var sMessFee_totalPaid = [Int]()
    var sMessFee_netDue = [Int]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        selectClass = -1
        selectStudent = -1
        self.tbl_studentWiseFee.delegate = self
        getClass()
        buildinUI()
        
    }

    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Student-Wise")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoSchoolFeeTableViewCell") as! SchoolFeeTableViewCell
            cell.sSchoolFee_termName = self.sSchoolFee_termName
            cell.sSchoolFee_label = self.sSchoolFee_label
            cell.sSchoolFee_termAmount = self.sSchoolFee_termAmount
            cell.sSchoolFee_scholarship = self.sSchoolFee_scholarship
            cell.sSchoolFee_Concession = self.sSchoolFee_Concession
            cell.sSchoolFee_Fine = self.sSchoolFee_Fine
            cell.sSchoolFee_total = self.sSchoolFee_total
            cell.sSchoolFee_totalPaid = self.sSchoolFee_totalPaid
            cell.sSchoolFee_netDue = self.sSchoolFee_netDue
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoHostelFeeTableViewCell") as! HostelFeeTableViewCell
            cell.sHostelFee_termName = self.sHostelFee_termName
            cell.sHostelFee_label = self.sHostelFee_label
            cell.sHostelFee_termAmount = self.sHostelFee_termAmount
            cell.sHostelFee_scholarship = self.sHostelFee_scholarship
            cell.sHostelFee_concession = self.sHostelFee_concession
            cell.sHostelFee_fine = self.sHostelFee_fine
            cell.sHostelFee_total = self.sHostelFee_total
            cell.sHostelFee_totalPaid = self.sHostelFee_totalPaid
            cell.sHostelFee_netDue = self.sHostelFee_netDue
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoTransportFeeTableViewCell") as! TransportFeeTableViewCell
            cell.sTransportFee_termName = self.sTransportFee_termName
            cell.sTransportFee_label = self.sTransportFee_label
            cell.sTransportFee_termAmount = self.sTransportFee_termAmount
            cell.sTransportFee_scholarship = self.sTransportFee_scholarship
            cell.sTransportFee_concession = self.sTransportFee_concession
            cell.sTransportFee_fine = self.sTransportFee_fine
            cell.sTransportFee_total = self.sTransportFee_total
            cell.sTransportFee_totalPaid = self.sTransportFee_totalPaid
            cell.sTransportFee_netDue = self.sTransportFee_netDue
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "gotoMessFeeTableViewCell") as! MessFeeTableViewCell
            cell.sMessFee_termName = self.sMessFee_termName
            cell.sMessFee_label = self.sMessFee_label
            cell.sMessFee_termAmount = self.sMessFee_termAmount
            cell.sMessFee_scholarship = self.sMessFee_scholarship
            cell.sMessFee_concession = self.sMessFee_concession
            cell.sMessFee_fine = self.sMessFee_fine
            cell.sMessFee_total = self.sMessFee_total
            cell.sMessFee_totalPaid = self.sMessFee_totalPaid
            cell.sMessFee_netDue = self.sMessFee_netDue
            return cell
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            if sSchoolFee_termName.count > 0{
                return CGFloat(sSchoolFee_termName.count*270)
            }
            return 70
        case 1:
            if sHostelFee_termName.count > 0{
                return CGFloat(sHostelFee_termName.count*270)
            }
            return 70
        case 2:
            if sTransportFee_termName.count > 0{
                return CGFloat(sTransportFee_termName.count*270)
            }
            return 70
        case 3:
            if sMessFee_termName.count > 0{
                return CGFloat(sMessFee_termName.count*270)
            }
            return 70
        default:
            return 70
        }
    }
    
    @IBAction func onClick_selectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectClass
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectClass.setTitle(item, for: .normal)
            self.selectClass = index            
            self.btn_selectStudent.setTitle("Select Student", for: .normal)
            self.getStudent()
        }
        dropDown.width = view_selectClass.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectStudent(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_selectStudent
        dropDown.dataSource = self.studentName
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_selectStudent.setTitle(item, for: .normal)
            self.selectStudent = index
            self.getStudentFee()
        }
        dropDown.width = view_selectStudent.frame.width
        dropDown.show()
    }
    
    func getClass(){
        present(processDialog, animated: true, completion: nil)
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
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
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
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            } catch let error as NSError {
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }
    
    func getStudent(){
        if selectClass < 0 {
            return
        }
        present(processDialog, animated: true, completion: nil)
        self.studentName.removeAll()
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let class_id: String = classID[selectClass]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_all_students_by_class")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&class_id=\(class_id)"
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
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let iStatus = parseData["status"] as! Int
                let sMessage = parseData["message"] as! String
                if iStatus == 1 {

                    let sResult = parseData["student_information_list"] as! [[String:AnyObject]]
                    for result in sResult {
                        let sStudentName = result["name"] as? String
                        let sLName = result["lname"] as? String
                        let sFullName: String!
                        sFullName = "\(sStudentName ?? "") \(sLName ?? "")"
                        self.studentName.append(sFullName!)
                        let studentID = result["student_id"] as? String
                        self.studentID.append(studentID!)
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            } catch let error as NSError {
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }
    
    func getStudentFee(){
        if selectClass < 0 {
            return
        }
        if selectStudent < 0 {
            return
        }
        removeAllValues()
        present(processDialog, animated: true, completion: nil)
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let student_id: String = studentID[selectStudent]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_student_wise_dues")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&student_id=\(student_id)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                    self.resultShow()
                })
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                    self.resultShow()
                })
            }
            
            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let iStatus = parseData["status"] as! Int
                let sMessage = parseData["message"] as! String
                if iStatus == 1 {
                    let sResult = parseData["student_detail"] as! [String:AnyObject]
                    self.sEnrollCode = sResult["enroll_code"] as? String
                    self.sGrade = sResult["class"] as? String
                    self.sDataOfAdmission = sResult["date_joined"] as? String
                    let sRecords = parseData["records"] as! [String:AnyObject]
                    let sSchoolFees = sRecords["school_fee"] as! [[String:Any]]
                    for sSchoolFee in sSchoolFees {
                        let SchoolFee_termName = sSchoolFee["term_name"] as! String
                        self.sSchoolFee_termName.append(SchoolFee_termName)
                        let SchoolFee_label = sSchoolFee["label"] as! String
                        self.sSchoolFee_label.append(SchoolFee_label)
                        let SchoolFee_termAmount = sSchoolFee["term_amount"] as! String
                        self.sSchoolFee_termAmount.append(SchoolFee_termAmount)
                        let SchoolFee_scholarship = sSchoolFee["scholarship_amt"] as! Int
                        self.sSchoolFee_scholarship.append(SchoolFee_scholarship)
                        let SchoolFee_concession = sSchoolFee["concession_amt"] as! Int
                        self.sSchoolFee_Concession.append(SchoolFee_concession)
                        let SchoolFee_fine = sSchoolFee["fine_amt"] as! Int
                        self.sSchoolFee_Fine.append(SchoolFee_fine)
                        let SchoolFee_total = sSchoolFee["total"] as! Int
                        self.sSchoolFee_total.append(SchoolFee_total)
                        let SchoolFee_totalPaid = sSchoolFee["paid_amt"] as! Int
                        self.sSchoolFee_totalPaid.append(SchoolFee_totalPaid)
                        let SchoolFee_netDue = sSchoolFee["net_due"] as! Int
                        self.sSchoolFee_netDue.append(SchoolFee_netDue)
                    }
                    let sHostelFees = sRecords["hostel_fee"] as! [[String:Any]]
                    for sHostelFee in sHostelFees {
                        let HostelFee_termName = sHostelFee["term_name"] as! String
                        self.sHostelFee_termName.append(HostelFee_termName)
                        let HostelFee_label = sHostelFee["label"] as! String
                        self.sHostelFee_label.append(HostelFee_label)
                        let HostelFee_termAmount = sHostelFee["term_amount"] as! String
                        self.sHostelFee_termAmount.append(HostelFee_termAmount)
                        let HostelFee_scholarship = sHostelFee["scholarship_amt"] as! Int
                        self.sHostelFee_scholarship.append(HostelFee_scholarship)
                        let HostelFee_concession = sHostelFee["concession_amt"] as! Int
                        self.sHostelFee_concession.append(HostelFee_concession)
                        let HostelFee_fine = sHostelFee["fine_amt"] as! Int
                        self.sHostelFee_fine.append(HostelFee_fine)
                        let HostelFee_total = sHostelFee["total"] as! Int
                        self.sHostelFee_total.append(HostelFee_total)
                        let HostelFee_totalPaid = sHostelFee["paid_amt"] as! Int
                        self.sHostelFee_totalPaid.append(HostelFee_totalPaid)
                        let HostelFee_netDue = sHostelFee["net_due"] as! Int
                        self.sHostelFee_netDue.append(HostelFee_netDue)
                    }
                    let sTransportFees = sRecords["transport_fee"] as! [[String:Any]]
                    for sTransportFee in sTransportFees {
                        let TransportFee_termName = sTransportFee["term_name"] as! String
                        self.sTransportFee_termName.append(TransportFee_termName)
                        let TransportFee_label = sTransportFee["label"] as! String
                        self.sTransportFee_label.append(TransportFee_label)
                        let TransportFee_termAmount = sTransportFee["term_amount"] as! String
                        self.sTransportFee_termAmount.append(TransportFee_termAmount)
                        let TransportFee_scholarship = sTransportFee["scholarship_amt"] as! Int
                        self.sTransportFee_scholarship.append(TransportFee_scholarship)
                        let TransportFee_concession = sTransportFee["concession_amt"] as! Int
                        self.sTransportFee_concession.append(TransportFee_concession)
                        let TransportFee_fine = sTransportFee["fine_amt"] as! Int
                        self.sTransportFee_fine.append(TransportFee_fine)
                        let TransportFee_total = sTransportFee["total"] as! Int
                        self.sTransportFee_total.append(TransportFee_total)
                        let TransportFee_totalPaid = sTransportFee["paid_amt"] as! Int
                        self.sTransportFee_totalPaid.append(TransportFee_totalPaid)
                        let TransportFee_netDue = sTransportFee["net_due"] as! Int
                        self.sTransportFee_netDue.append(TransportFee_netDue)
                    }
                    let sMessFees = sRecords["mess_fee"] as! [[String:Any]]
                    for sMessFee in sMessFees {
                        let MessFee_termName = sMessFee["term_name"] as! String
                        self.sMessFee_termName.append(MessFee_termName)
                        let MessFee_label = sMessFee["label"] as! String
                        self.sMessFee_label.append(MessFee_label)
                        let MessFee_termAmount = sMessFee["term_amount"] as! String
                        self.sMessFee_termAmount.append(MessFee_termAmount)
                        let MessFee_scholarship = sMessFee["scholarship_amt"] as! Int
                        self.sMessFee_scholarship.append(MessFee_scholarship)
                        let MessFee_concession = sMessFee["concession_amt"] as! Int
                        self.sMessFee_concession.append(MessFee_concession)
                        let MessFee_fine = sMessFee["fine_amt"] as! Int
                        self.sMessFee_fine.append(MessFee_fine)
                        let MessFee_total = sMessFee["total"] as! Int
                        self.sMessFee_total.append(MessFee_total)
                        let MessFee_totalPaid = sMessFee["paid_amt"] as! Int
                        self.sMessFee_totalPaid.append(MessFee_totalPaid)
                        let MessFee_netDue = sMessFee["net_due"] as! Int
                        self.sMessFee_netDue.append(MessFee_netDue)
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                    self.resultShow()
                })
                self.resultShow()
            } catch let error as NSError {
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }

    func buildinUI(){
        view_selectClassTop.layer.borderWidth = 1
        view_selectClassTop.layer.cornerRadius = 5
        view_selectClassTop.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        ivew_selectStudentTop.layer.borderWidth = 1
        ivew_selectStudentTop.layer.cornerRadius = 5
        ivew_selectStudentTop.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func resultShow(){
        DispatchQueue.main.async(execute: {
            self.view_top1.layer.borderWidth = 1
            self.view_top1.layer.cornerRadius = 5
            self.view_top1.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
            self.tbl_studentWiseFee.dataSource = self
            self.tbl_studentWiseFee.reloadData()
            self.lbl_titleEnrollCode.text = "Enroll Code"
            self.lbl_enrollCode.text = self.sEnrollCode
            self.lbl_titleStudentName.text = "Student Name"
            self.lbl_studentName.text = self.studentName[self.selectStudent]
            self.lbl_titleGrade.text = "Grade"
            self.lbl_grade.text = self.sGrade
            self.lbl_titleDateOfAdmission.text = "Date of Admission"
            self.lbl_dateOfAdmission.text = self.sDataOfAdmission
        })
    }
    
    func removeAllValues(){
        sSchoolFee_termName.removeAll()
        sSchoolFee_label.removeAll()
        sSchoolFee_termAmount.removeAll()
        sSchoolFee_scholarship.removeAll()
        sSchoolFee_Concession.removeAll()
        sSchoolFee_Fine.removeAll()
        sSchoolFee_total.removeAll()
        sSchoolFee_totalPaid.removeAll()
        sSchoolFee_netDue.removeAll()
        sHostelFee_termName.removeAll()
        sHostelFee_label.removeAll()
        sHostelFee_termAmount.removeAll()
        sHostelFee_scholarship.removeAll()
        sHostelFee_concession.removeAll()
        sHostelFee_fine.removeAll()
        sHostelFee_total.removeAll()
        sHostelFee_totalPaid.removeAll()
        sHostelFee_netDue.removeAll()
        sTransportFee_termName.removeAll()
        sTransportFee_label.removeAll()
        sTransportFee_termAmount.removeAll()
        sTransportFee_scholarship.removeAll()
        sTransportFee_concession.removeAll()
        sTransportFee_fine.removeAll()
        sTransportFee_total.removeAll()
        sTransportFee_totalPaid.removeAll()
        sTransportFee_netDue.removeAll()
        sMessFee_termName.removeAll()
        sMessFee_label.removeAll()
        sMessFee_termAmount.removeAll()
        sMessFee_scholarship.removeAll()
        sMessFee_concession.removeAll()
        sMessFee_fine.removeAll()
        sMessFee_total.removeAll()
        sMessFee_totalPaid.removeAll()
        sMessFee_netDue.removeAll()
    }
}
































