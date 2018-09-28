import UIKit
import DatePickerDialog
import DropDown
class DailyAttendanceViewController: UIViewController {

    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var view_selectClass: UIView!
    @IBOutlet weak var brn_selectClass: UIButton!
    @IBOutlet weak var view_seelctClassDrop: UIView!
    
    @IBOutlet weak var view_slectSection: UIView!
    @IBOutlet weak var btn_selectSection: UIButton!
    @IBOutlet weak var view_selectSectionDrop: UIView!
    
    @IBOutlet weak var view_selectDate: UIView!
    @IBOutlet weak var btn_selectDate: UIButton!
    
    var classNames = [String]()
    var classID = [String]()
    
    var sectionNmaes = [[String]]()
    var sectionIDs = [[String]]()
    
    var date = String()
    
    var selectClass = Int()
    var selectSection = Int()
    
    var stud_images = [String]()
    var stud_names = [String]()
    var in_time = [String]()
    var out_time = [String]()
    var status = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClassNames()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! DailyAttendanceTableViewController
        DestinationViewController.names = stud_names
        DestinationViewController.img_urls = stud_images
        DestinationViewController.in_times = in_time
        DestinationViewController.out_times = out_time
        DestinationViewController.status = status
    }
    
    @IBAction func onClick_selectClass(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_seelctClassDrop
        dropDown.dataSource = self.classNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.brn_selectClass .setTitle(item, for: UIControlState.normal)
            self.btn_selectSection.setTitle("Select Secssion", for: UIControlState.normal)
            self.selectClass = index
            self.selectSection = -1
        }
        dropDown.width = view_seelctClassDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectSection(_ sender: UIButton, forEvent event: UIEvent) {
        if selectClass < 0 {
            return
        }
        let dropDown = DropDown()
        dropDown.anchorView = view_selectSectionDrop
        dropDown.dataSource = self.sectionNmaes[selectClass]
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in self.btn_selectSection.setTitle(self.sectionNmaes[self.selectClass][index], for: UIControlState.normal)
            self.selectSection = index
        }
        dropDown.width = view_selectSectionDrop.frame.width
        dropDown.show()
    }
    
    @IBAction func onClick_selectDate(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_viewAttendace(_ sender: UIButton, forEvent event: UIEvent) {
        if selectClass < 0 || selectSection < 0 {
            return
        }
        self.date = self.btn_selectDate.title(for: .normal) ?? ""
        if date.count < 5 {
            return
        }
        getDailyAttendance()
    }
    
    func buildUI(){
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectClass.layer.borderWidth = 1
        view_selectClass.layer.cornerRadius = 5
        view_selectClass.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_slectSection.layer.borderWidth = 1
        view_slectSection.layer.cornerRadius = 5
        view_slectSection.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_selectDate.layer.borderWidth = 1
        view_selectDate.layer.cornerRadius = 5
        view_selectDate.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func initParams(){
        selectClass = -1
        selectSection = -1        
    }

    func getClassNames(){
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
                    var sectionNameArray = [String]()
                    var sectionIDArray = [String]()
                    for result in sResult {
                        if let sClassName = result["name"] as? String {
                            self.classNames.append(sClassName)
                        }
                        if let sClassID = result["class_id"] as? String {
                            self.classID.append(sClassID)
                        }
                        if let sections = result["sections"] as? [[String:AnyObject]]{
                            for section in sections {
                                let sectionName = section["name"] as? String
                                let sectionID = section["section_id"] as? String
                                sectionNameArray.append(sectionName!)
                                sectionIDArray.append(sectionID!)
                            }
                        }
                        self.sectionNmaes.append(sectionNameArray)
                        self.sectionIDs.append(sectionIDArray)
                        sectionNameArray.removeAll()
                        sectionIDArray.removeAll()
                    }
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func getDailyAttendance(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let date = self.date
        let class_id: String = self.classID[selectClass]
        let section_id: String = self.sectionIDs[selectClass][selectSection]
        let url = URL(string: "https://demo.rarome.com/index.php/?api/native_get_attendance_student_list")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&class_id=\(class_id)&section_id=\(section_id)section_id=\(date)"
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
                    let sResult = parseData["attendance"] as! [[String:AnyObject]]
                    for result in sResult {
                        let sStudentName = result["name"] as? String
                        let sLName = result["lname"] as? String
                        let sFullName: String!
                        sFullName = "\(sStudentName ?? "") \(sLName ?? "")"
                        self.stud_names.append(sFullName)
                        let imgUrl = result["stud_image"] as? String
                        if imgUrl == nil {
                            self.stud_images.append("")
                        } else {
                            self.stud_images.append(imgUrl!)
                        }
                        let time_in = result["in_time"] as? String
                        if time_in == nil {
                            self.in_time.append("null")
                        } else {
                            self.in_time.append(time_in!)
                        }
                        let time_out = result["out_time"] as? String
                        if time_out == nil {
                            self.out_time.append("null")
                        } else {
                            self.out_time.append(time_out!)
                        }
                        let statu = result["timing_status"] as? String
                        if statu == nil {
                            self.status.append("null")
                        } else {
                            self.status.append(statu!)
                        }
                    }
                }
                DispatchQueue.main.async(execute: {
                    self.performSegue(withIdentifier: "gotoDailyAttendance", sender: self)
                })
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
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
}
