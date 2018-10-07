//
//  SubjectReportTableViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/4/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
var starRatings = [Float]()
var descriptions = [String]()
class SubjectReportTableViewController: UITableViewController, UITextViewDelegate {

    var sUserImgUrl = [String]()
    var sUserNames = [String]()
    var sUserIDs = [String]()
    
    var button: UIButton!
    var query = [[String : String]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        button = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width - self.view.frame.width/2 - 80, y: self.view.frame.height - 60), size: CGSize(width: 160, height: 45)))
        button.backgroundColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("Add Report", for: .normal)
        button.addTarget(self, action: #selector(onAddProgreeReport(_:)), for: UIControlEvents.touchUpInside)
        
        for _ in 0 ..< sUserNames.count{
            starRatings.append(0)
            descriptions.append("")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        button.removeFromSuperview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.view.addSubview(button)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sUserNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoSubjectReportTableViewCell", for: indexPath) as! SubjectReportTableViewCell
        cell.lbl_name.text = self.sUserNames[indexPath.row]
        cell.index = indexPath.row
        cell.star.value = starRatings[indexPath.row]
        cell.sStudentID = self.sUserIDs[indexPath.row]
        return cell
    }

    func onAddProgreeReport(_ sender: UIButton){
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let class_id = GlobalConst.glb_classID ?? ""
        let section_id = GlobalConst.glb_sectionID ?? ""
        let subject_id = GlobalConst.glb_subjectID ?? ""
        
        makeSubjectWiseReport()
        var subjectwise_report = String()
        if JSONSerialization.isValidJSONObject(self.query){
            do{
                let rawData = try JSONSerialization.data(withJSONObject: query, options: JSONSerialization.WritingOptions.prettyPrinted)
                subjectwise_report = String(data: rawData, encoding: String.Encoding.utf8)!
            } catch let myJSONError{
                print(myJSONError)
            }
        }
        let url = URL(string: "https://demo.rarome.com/index.php/?api/add_rating_subject_wise_progress_report")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&section_id=\(section_id)&class_id=\(class_id)&subject_id=\(subject_id)&subjectwise_report=\(subjectwise_report)"
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

                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func makeSubjectWiseReport(){
        self.query.removeAll()
        for i in stride(from: 0, to: self.sUserIDs.count, by: 1){
            let student_id = self.sUserIDs[i] ?? ""
            let comment = descriptions[i] ?? ""
            let rating = String(Int(starRatings[i]))
            let someProtocal = [
                "student_id" : student_id ?? "",
                "comment" : comment ?? "",
                "rating" : rating ?? ""]
            self.query.append(someProtocal)
        }
    }
}
