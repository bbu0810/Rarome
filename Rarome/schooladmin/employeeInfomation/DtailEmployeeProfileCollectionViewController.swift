import UIKit
class DtailEmployeeProfileCollectionViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var lbl_fullName: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_dateOfBirthday: UILabel!
    @IBOutlet weak var lbl_gender: UILabel!
    @IBOutlet weak var lbl_yearsOfExp: UILabel!
    @IBOutlet weak var lbl_dateOfJoining: UILabel!
    @IBOutlet weak var lbl_phoneNumber: UILabel!
    @IBOutlet weak var lbl_salary: UILabel!
    @IBOutlet weak var lbl_leaves: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_bankName: UILabel!
    @IBOutlet weak var lbl_accountType: UILabel!
    @IBOutlet weak var lbl_accountNo: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var tbl_employmentHistory: UITableView!
    @IBOutlet weak var tbl_educationDetails: UITableView!
    
    
    var sEmploymentHistory_company = [String]()
    var sEmploymentHistory_website = [String]()
    var sEmploymentHistory_designation = [String]()
    var sEmploymentHistory_companyFrom = [String]()
    var sEmploymentHistory_companyTo = [String]()
    
    var sCourseDetail_course = [String]()
    var sCourseDetail_institute = [String]()
    var sCourseDetail_percentage = [String]()
    var sCourseDetail_courseFrom = [String]()
    var sCourseDetail_courseTo = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailProfile()
        lbl_fullName.text = GlobalConst.glb_sEmployeeName
        lbl_email.text = GlobalConst.glb_sEmail
        lbl_dateOfBirthday.text = GlobalConst.glb_sDateOfBirthday
        lbl_gender.text = GlobalConst.glb_sGender
        lbl_yearsOfExp.text = GlobalConst.glb_sYearsOfExp
        lbl_dateOfJoining.text = GlobalConst.glb_sDateOfJoning
        lbl_phoneNumber.text = GlobalConst.glb_sPhoneNumber
        lbl_salary.text = GlobalConst.glb_sSalar
        lbl_status.text = GlobalConst.glb_sStatus
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cell_employ:EmploymentHistoryDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoEmploymentHistoryDetailTableViewCell") as? EmploymentHistoryDetailTableViewCell
        if cell_employ == nil {
            var cell_course:EducationDetailViewTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoDeucationDetailViewTableViewCell") as? EducationDetailViewTableViewCell
            if cell_course == nil{
                return 0
                
            }
            return sCourseDetail_course.count
        }
        return sEmploymentHistory_company.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell_employ:EmploymentHistoryDetailTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoEmploymentHistoryDetailTableViewCell") as? EmploymentHistoryDetailTableViewCell
        if cell_employ == nil {
            var cell_course:EducationDetailViewTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "gotoDeucationDetailViewTableViewCell") as? EducationDetailViewTableViewCell
            if cell_course == nil{
                return cell_course!
            }
            cell_course?.lbl_course.text = sCourseDetail_course[indexPath.row]
            cell_course?.lbl_institution.text = sCourseDetail_institute[indexPath.row]
            cell_course?.lbl_percentage.text = sCourseDetail_percentage[indexPath.row]
            cell_course?.lbl_courseFrom.text = sCourseDetail_courseFrom[indexPath.row]
            cell_course?.lbl_courseTo.text = sCourseDetail_courseTo[indexPath.row]
            return cell_course!
        }
        cell_employ?.lbl_cmpanyName.text = sEmploymentHistory_company[indexPath.row]
        cell_employ?.lbl_website.text = sEmploymentHistory_website[indexPath.row]
        cell_employ?.lbl_designation.text = sEmploymentHistory_designation[indexPath.row]
        cell_employ?.lbl_companyFrom.text = sEmploymentHistory_companyFrom[indexPath.row]
        cell_employ?.lbl_companyTo.text = sEmploymentHistory_companyTo[indexPath.row]
        return cell_employ!
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
                            self.sEmploymentHistory_company.append(company_name)
                            self.sEmploymentHistory_website.append(website)
                            self.sEmploymentHistory_designation.append(designation)
                            self.sEmploymentHistory_companyFrom.append(company_from)
                            self.sEmploymentHistory_companyTo.append(company_to)
                        }
                        let sEmployEducateHistorys = parseData["employee_education"] as! [[String:AnyObject]]
                        for sEmployEducateHistory in sEmployEducateHistorys {
                            let course = sEmployEducateHistory["course"] as! String
                            let institution = sEmployEducateHistory["institution"] as! String
                            let percentage = sEmployEducateHistory["percentage"] as! String
                            let course_from = sEmployEducateHistory["course_from"] as! String
                            let course_to = sEmployEducateHistory["course_to"] as! String
                            self.sCourseDetail_course.append(course)
                            self.sCourseDetail_institute.append(institution)
                            self.sCourseDetail_percentage.append(percentage)
                            self.sCourseDetail_courseFrom.append(course_from)
                            self.sCourseDetail_courseTo.append(course_to)
                        }
                        self.buildUI()
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        }

    func buildUI(){
        DispatchQueue.main.async(execute: {
            self.tbl_employmentHistory.dataSource = self
            self.tbl_educationDetails.dataSource = self
            self.tbl_employmentHistory.reloadData()
            self.tbl_educationDetails.reloadData()
        })
    }
}
