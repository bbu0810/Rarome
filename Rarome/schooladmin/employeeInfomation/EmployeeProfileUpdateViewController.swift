//
//  EmployeeProfileUpdateViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/9/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DatePickerDialog
import TextFieldEffects
import DropDown
class EmployeeProfileUpdateViewController: UIViewController, UITableViewDataSource, UITextViewDelegate{
  
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txt_name: HoshiTextField!
    @IBOutlet weak var txt_lastName: HoshiTextField!
    
    @IBOutlet weak var btn_dateOfBirthPicker: UIButton!
    @IBOutlet weak var view_dateOfBirth: UIView!
    
    @IBOutlet weak var view_gender: UIView!
    @IBOutlet weak var btn_gender: UIButton!
    @IBOutlet weak var view_gender_drop: UIView!
    
    @IBOutlet weak var text_email: HoshiTextField!
    @IBOutlet weak var txt_phoneNumber: HoshiTextField!
    @IBOutlet weak var txt_yearsOfExperience: HoshiTextField!
    
    @IBOutlet weak var view_department: UIView!
    @IBOutlet weak var btn_Department: UIButton!
    @IBOutlet weak var view_department_drop: UIView!
    
    @IBOutlet weak var view_role: UIView!
    @IBOutlet weak var btn_role: UIButton!
    @IBOutlet weak var view_role_drop: UIView!

    @IBOutlet weak var view_dateOfJoining: UIView!
    @IBOutlet weak var btn_dateOfJoining: UIButton!

    @IBOutlet weak var txt_salary: HoshiTextField!
    @IBOutlet weak var txt_leaves: HoshiTextField!
    @IBOutlet weak var txt_homeNumber: HoshiTextField!
    @IBOutlet weak var txt_address: HoshiTextField!
    
    @IBOutlet weak var btn_radio_isTeacher_yes: UIButton!
    @IBOutlet weak var btn_radio_isTeacher_no: UIButton!

    @IBOutlet weak var txt_bankName: HoshiTextField!
    @IBOutlet weak var txt_bankRecordName: HoshiTextField!
    
    @IBOutlet weak var view_accountType: UIView!
    @IBOutlet weak var btn_accountType: UIButton!
    @IBOutlet weak var view_account_drop: UIView!

    @IBOutlet weak var txt_accountNumber: HoshiTextField!
    @IBOutlet weak var txt_bankAccountRef: HoshiTextField!
    
    @IBOutlet weak var tbl_employmentHistory: UITableView!
    @IBOutlet weak var btn_employmentHistoryAdd: UIButton!
    
    @IBOutlet weak var tbl_courseDetails: UITableView!
    @IBOutlet weak var btn_courseDetailsAdd: UIButton!
    
    let gender = ["Male", "Famale"]
    var role = [String]()
    var roleIDs = [String]()
    let accountType = ["Saving Account", "Current Account"]
    
    var department_id = String()
    var roleID = String()
    
    static var count_employeeHistoryTableCells: Int!
    static var count_courseTableCells: Int!
    
    var employeeHistory_companys = [String]()
    var employeeHistory_websites = [String]()
    var employeeHistory_designation = [String]()
    var employeeHistory_fromDate = [String]()
    var employeeHistory_toDate = [String]()
    var employeHistory_quary = [[String:String]]()
    
    var courseDetail_course = [String]()
    var courseDetail_institute = [String]()
    var courseDetail_percentage = [String]()
    var courseDetail_fromDate = [String]()
    var courseDetail_toDate = [String]()
    var courseDetail_quary = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRoleNams()
        initParams()
        buildUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cell_employ:EmploymentHistoryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoEmploymentHistoryTableViewCell") as? EmploymentHistoryTableViewCell
        if cell_employ == nil {
            var cell_course:CourseDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoCourseDetailsTableViewCell") as? CourseDetailTableViewCell
            if cell_course == nil{
                return 0
                
            }
            return EmployeeProfileUpdateViewController.count_courseTableCells
        }
        return EmployeeProfileUpdateViewController.count_employeeHistoryTableCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_employ:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoEmploymentHistoryTableViewCell")
        if cell_employ == nil {
            var cell_course:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoCourseDetailsTableViewCell")
            if cell_course == nil{
                return cell_course!
            }
//            cell_course?.txt_course.text = courseDetail_course[indexPath.row]
//            cell_course?.txt_institute.text = courseDetail_institute[indexPath.row]
//            cell_course?.txt_percentage.text = courseDetail_percentage[indexPath.row]
//            cell_course?.btn_courseFrom.setTitle(courseDetail_fromDate[indexPath.row], for: .normal)
//            cell_course?.btn_courseTo.setTitle(courseDetail_toDate[indexPath.row], for: .normal)
            return cell_course!
        }
//        cell_employ?.txt_company.text = employeeHistory_companys[indexPath.row]
//        cell_employ?.txt_website.text = employeeHistory_websites[indexPath.row]
//        cell_employ?.txt_designation.text = employeeHistory_designation[indexPath.row]
//        cell_employ?.btn_companyFrom.setTitle(employeeHistory_fromDate[indexPath.row], for: .normal)
//        cell_employ?.btn_companyTo.setTitle(employeeHistory_toDate[indexPath.row], for: .normal)
        return cell_employ!
    }
    
    @IBAction func onClick_dateOfBirthPicker(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }

    @IBAction func onClick_gender(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_gender_drop
        dropDown.dataSource = self.gender
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_gender.setTitle(item, for: UIControlState.normal)
        }
        dropDown.width = view_gender.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_department(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_department_drop
        dropDown.dataSource = GlobalConst.glb_sDepartmentNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_Department.setTitle(item, for: UIControlState.normal)
            self.department_id = GlobalConst.glb_sDeparmentIDs[index]
        }
        dropDown.width = view_department.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_role(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_role_drop
        dropDown.dataSource = self.role
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_role.setTitle(item, for: UIControlState.normal)
            self.roleID = self.roleIDs[index]
        }
        dropDown.width = view_role.frame.width
        dropDown.show()
    }

    @IBAction func onClick_dateOfJoining(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_isTeacher_yes(_ sender: UIButton, forEvent event: UIEvent) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        if btn_radio_isTeacher_yes.isSelected == true {
            btn_radio_isTeacher_no.isSelected = true
        } else {
            btn_radio_isTeacher_no.isSelected = false
        }
    }

    @IBAction func onClick_isTeacher_no(_ sender: UIButton, forEvent event: UIEvent) {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
        if btn_radio_isTeacher_no.isSelected == true {
            btn_radio_isTeacher_yes.isSelected = true
        } else {
            btn_radio_isTeacher_yes.isSelected = false
        }
    }

    @IBAction func onClick_accountType(_ sender: UIButton, forEvent event: UIEvent) {
        
        let dropDown = DropDown()
        dropDown.anchorView = view_account_drop
        dropDown.dataSource = self.accountType
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.btn_accountType.setTitle(item, for: UIControlState.normal)
        }
        dropDown.width = view_accountType.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_addEmployeeHistory(_ sender: UIButton, forEvent event: UIEvent) {
        EmployeeProfileUpdateViewController.count_employeeHistoryTableCells = EmployeeProfileUpdateViewController.count_employeeHistoryTableCells + 1
        tbl_employmentHistory.reloadData()
    }
    
    @IBAction func onClick_deleteEmployeeHistory(_ sender: UIButton, forEvent event: UIEvent) {
        tbl_employmentHistory.reloadData()
    }
    
    @IBAction func onClick_courseDetail(_ sender: UIButton, forEvent event: UIEvent) {
        EmployeeProfileUpdateViewController.count_courseTableCells = EmployeeProfileUpdateViewController.count_courseTableCells + 1
        tbl_courseDetails.reloadData()
    }

    @IBAction func onClick_deleteCourseDetails(_ sender: UIButton, forEvent event: UIEvent) {
        tbl_courseDetails.reloadData()        
    }
    
    @IBAction func onClick_update(_ sender: UIButton, forEvent event: UIEvent) {
        getEmploymentHistory()
        makeEmploymentHistory()
        getCourseDetail()
        makeCourseDetail()
        submitProfile()
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
    

    func buildUI(){
        view_dateOfBirth.layer.borderWidth = 1
        view_dateOfBirth.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_gender.layer.borderWidth = 1
        view_gender.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_department.layer.borderWidth = 1
        view_department.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_role.layer.borderWidth = 1
        view_role.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_dateOfJoining.layer.borderWidth = 1
        view_dateOfJoining.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        btn_radio_isTeacher_yes.setImage(UIImage(named:"radio_unclick"), for: .normal)
        btn_radio_isTeacher_yes.setImage(UIImage(named:"radio_click"), for: .selected)
        btn_radio_isTeacher_yes.isSelected = true
        
        btn_radio_isTeacher_no.setImage(UIImage(named:"radio_unclick"), for: .normal)
        btn_radio_isTeacher_no.setImage(UIImage(named:"radio_click"), for: .selected)
        
        view_accountType.layer.borderWidth = 1
        view_accountType.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor

        txt_name.text = GlobalConst.glb_sEmployeeFirstName
        txt_lastName.text = GlobalConst.glb_sEmployeeLastName
        btn_dateOfBirthPicker.setTitle(GlobalConst.glb_sDateOfBirthday, for: .normal)
        btn_gender.setTitle(GlobalConst.glb_sGender, for: .normal)
        text_email.text = GlobalConst.glb_sEmail
        txt_phoneNumber.text = GlobalConst.glb_sPhoneNumber
        txt_yearsOfExperience.text = GlobalConst.glb_sYearsOfExp
        btn_role.setTitle(GlobalConst.glb_RoleName, for: .normal)
        btn_dateOfJoining.setTitle(GlobalConst.glb_sDateOfJoning, for: .normal)
        txt_salary.text = GlobalConst.glb_sSalar
        txt_leaves.text = GlobalConst.glb_sLeave
        txt_homeNumber.text = GlobalConst.glb_homeNumber
        txt_address.text = GlobalConst.glb_sAddress
        txt_bankName.text = GlobalConst.glb_sBankName
        txt_bankRecordName.text = GlobalConst.glb_sBankrecordName
        txt_accountNumber.text = GlobalConst.glb_sAccountNo
        txt_bankAccountRef.text = GlobalConst.glb_sBankAccountRef
    }
    
    func initParams(){
        EmployeeProfileUpdateViewController.count_employeeHistoryTableCells = 1
        EmployeeProfileUpdateViewController.count_courseTableCells = 1
        department_id = GlobalConst.glb_sDepartmentID
        self.tbl_employmentHistory.dataSource = self
        self.tbl_courseDetails.dataSource = self
        self.tbl_employmentHistory.reloadData()
        self.tbl_courseDetails.reloadData()
    }
    
    func getRoleNams(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let departmentID: String = GlobalConst.glb_sDepartmentID
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
                    let sResults = parseData["role_list"] as! [[String:AnyObject]]
                    for result in sResults{
                        let roleName = result["role"] as? String
                        self.role.append(roleName!)
                        let roleId = result["id"] as? String
                        self.roleIDs.append(roleId!)
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getDetailProfile(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let employee_id = GlobalConst.glb_sEmployeeID ?? ""
        let url = URL(string: "https://demo.rarome.com/index.php/?api/employee_view")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&employee_id=\(employee_id)"
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
                    let sEmployHistorys = parseData["employee_experience"] as! [[String:AnyObject]]
                    for sEmployHistory in sEmployHistorys {
                        let company_name = sEmployHistory["company_name"] as! String
                        let website = sEmployHistory["website"] as! String
                        let designation = sEmployHistory["designation"] as! String
                        let company_from = sEmployHistory["company_from"] as! String
                        let company_to = sEmployHistory["company_to"] as! String
                        self.employeeHistory_companys.append(company_name)
                        self.employeeHistory_websites.append(website)
                        self.employeeHistory_designation.append(designation)
                        self.employeeHistory_fromDate.append(company_from)
                        self.employeeHistory_toDate.append(company_to)
                    }
                    let sEmployEducateHistorys = parseData["employee_education"] as! [[String:AnyObject]]
                    for sEmployEducateHistory in sEmployEducateHistorys {
                        let course = sEmployEducateHistory["course"] as! String
                        let institution = sEmployEducateHistory["institution"] as! String
                        let percentage = sEmployEducateHistory["percentage"] as! String
                        let course_from = sEmployEducateHistory["course_from"] as! String
                        let course_to = sEmployEducateHistory["course_to"] as! String
                        self.courseDetail_course.append(course)
                        self.courseDetail_institute.append(institution)
                        self.courseDetail_percentage.append(percentage)
                        self.courseDetail_fromDate.append(course_from)
                        self.courseDetail_toDate.append(course_to)
                    }
                }
//                DispatchQueue.main.async(execute: {
//                    self.tbl_employmentHistory.dataSource = self
//                    self.tbl_courseDetails.dataSource = self
//                    self.tbl_employmentHistory.reloadData()
//                    self.tbl_courseDetails.reloadData()
//                })
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func submitProfile(){
        
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let employee_id: String = GlobalConst.glb_sEmployeeID
        let f_name: String! = txt_name.text!
        if validationCheck(fieldName: "Name", string: f_name!) == false{
            return
        }
        let l_name: String! = txt_lastName.text
        let dob: String! = btn_dateOfBirthPicker.title(for: .normal)
        let gender: String! = btn_gender.title(for: .normal)
        let email: String! = text_email.text
        if validationCheck(fieldName: "Email", string: email!) == false{
            return
        }
        let phone_number: String! = txt_phoneNumber.text
        if validationCheck(fieldName: "Phone Number", string: phone_number!) == false{
            return
        }
        let year_of_exp: String! = txt_yearsOfExperience.text
        if validationCheck(fieldName: "Years of Experience", string: year_of_exp!) == false{
            return
        }
        let department_id = self.department_id
        let role_id = self.roleID
        let date_of_joining: String? = btn_dateOfJoining.title(for: .normal)
        let salary: String = txt_salary.text!
        let emp_leaves: String = txt_leaves.text!
        let home_number: String = txt_homeNumber.text!
        var is_teacher = String()
        if btn_radio_isTeacher_yes.isSelected == true {
            is_teacher = "1"
        } else {
            is_teacher = "0"
        }
        let bank_name: String = txt_bankName.text!
        let bank_record_name: String = txt_bankRecordName.text!
        let bank_account_type: String = btn_accountType.title(for: .normal)!
        let bank_account_number: String = txt_accountNumber.text!
        let bank_account_ref: String = txt_bankAccountRef.text!
        let url = URL(string: "https://demo.rarome.com/index.php/?api/update_employee")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var query_employmentHisotry = String()
        var query_courseDetail = String()
        if JSONSerialization.isValidJSONObject(self.employeHistory_quary) {
            do{
               let rawData =  try JSONSerialization.data(withJSONObject: self.employeHistory_quary, options: JSONSerialization.WritingOptions.prettyPrinted)
                query_employmentHisotry = String(data: rawData, encoding: String.Encoding.utf8)!
            }catch let myJSONError{
                print(myJSONError)
            }
        }
        if JSONSerialization.isValidJSONObject(self.courseDetail_quary) {
            do{
                let rawData =  try JSONSerialization.data(withJSONObject: self.courseDetail_quary, options: JSONSerialization.WritingOptions.prettyPrinted)
                query_courseDetail = String(data: rawData, encoding: String.Encoding.utf8)!
            }catch let myJSONError{
                print(myJSONError)
            }
        }
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&employee_id=\(employee_id)&f_name=\(f_name ?? "")&l_name=\(l_name ?? "")&dob=\(dob ?? "")&gender=\(gender ?? "")&email=\(email ?? "")&phone_number=\(phone_number ?? "")&year_of_exp=\(year_of_exp ?? "")&department_id=\(department_id ?? "")&role_id=\(role_id ?? "")&date_of_joining=\(date_of_joining ?? "")&salary=\(salary ?? "")&emp_leaves=\(emp_leaves ?? "")&home_number=\(home_number ?? "")&is_teacher=\(is_teacher ?? "")&bank_name=\(bank_name ?? "")&bank_record_name=\(bank_record_name ?? "")&bank_account_type=\(bank_account_type ?? "")&bank_account_number=\(bank_account_number ?? "")&bank_account_ref=\(bank_account_ref ?? "")&company_datail=\(query_employmentHisotry)&education_detail=\(query_courseDetail)"
        request.httpBody = postString.data(using: .utf8)

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
                    self.showResult(message: sMessage)
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getEmploymentHistory(){
        self.employeeHistory_companys.removeAll()
        self.employeeHistory_websites.removeAll()
        self.employeeHistory_designation.removeAll()
        self.employeeHistory_fromDate.removeAll()
        self.employeeHistory_toDate.removeAll()
        for i in stride(from: 0, to: EmployeeProfileUpdateViewController.count_employeeHistoryTableCells, by: 1) {
            let cell = tbl_employmentHistory.cellForRow(at: .init(row: i, section: 0)) as? EmploymentHistoryTableViewCell
            self.employeeHistory_companys.append((cell?.txt_company.text)!)
            self.employeeHistory_websites.append((cell?.txt_website.text)!)
            self.employeeHistory_designation.append((cell?.txt_designation.text)!)
            self.employeeHistory_fromDate.append((cell?.btn_companyTo.title(for: .normal))!)
            self.employeeHistory_toDate.append((cell?.btn_companyFrom.title(for: .normal))!)
        }
    }
    
    func makeEmploymentHistory(){
        employeHistory_quary.removeAll()
        for i in stride(from: 0, to: EmployeeProfileUpdateViewController.count_employeeHistoryTableCells, by: 1){
            let company_name = self.employeeHistory_companys[i]
            let website = self.employeeHistory_companys[i]
            let designation = self.employeeHistory_designation[i]
            let from = self.employeeHistory_fromDate[i]
            let to = self.employeeHistory_toDate[i]
            let someProtocol = [
                "company_name" : company_name,
                "website" : website,
                "designation" : designation,
                "from" : from,
                "to" : to
            ]
            self.employeHistory_quary.append(someProtocol)
        }
    }
    
    func getCourseDetail(){
        self.courseDetail_course.removeAll()
        self.courseDetail_institute.removeAll()
        self.courseDetail_percentage.removeAll()
        self.courseDetail_fromDate.removeAll()
        self.courseDetail_toDate.removeAll()
        for i in stride(from: 0, to: EmployeeProfileUpdateViewController.count_courseTableCells, by: 1){
            let cell = tbl_courseDetails.cellForRow(at: .init(row: i, section: 0)) as? CourseDetailTableViewCell
            self.courseDetail_course.append((cell?.txt_course.text)!)
            self.courseDetail_institute.append((cell?.txt_institute.text)!)
            self.courseDetail_percentage.append((cell?.txt_percentage.text)!)
            self.courseDetail_fromDate.append((cell?.btn_courseFrom.title(for: .normal))!)
            self.courseDetail_toDate.append((cell?.btn_courseTo.title(for: .normal))!)
        }
    }
    
    func makeCourseDetail(){
        courseDetail_quary.removeAll()
        for i in stride(from: 0, to: EmployeeProfileUpdateViewController.count_courseTableCells, by: 1){
            let course = self.courseDetail_course[i]
            let institute = self.courseDetail_institute[i]
            let percentage = self.courseDetail_percentage[i]
            let course_from = self.courseDetail_fromDate[i]
            let course_to = self.courseDetail_toDate[i]
            let someProtocol = [
                "course" : course,
                "institute" : institute,
                "percentage" : percentage,
                "course_from" : course_from,
                "course_to" : course_to
            ]
            self.courseDetail_quary.append(someProtocol)
        }
    }
    
    func validationCheck(fieldName: String, string: String) -> Bool{
        if string.count == 0 {
            showResult(fieldName: fieldName)
            return false
        } else {
            return true
        }
    }
    
    func showResult(fieldName: String){
        DispatchQueue.main.async(execute: {
            let message = "\(fieldName) is empty. Please insert!"
            let alert = UIAlertController(title: "Worrning", message: message, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
    
    func showResult(message: String){
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
            let submitAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
            alert.addAction(submitAction)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
}
