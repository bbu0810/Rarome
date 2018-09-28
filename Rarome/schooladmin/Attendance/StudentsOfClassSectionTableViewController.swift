//
//  StudentsOfClassSectionTableViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/17/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class StudentsOfClassSectionTableViewController: UITableViewController {
    
    var studentNames = [String]()
    var studentIDs = [String]()
    var studenImgURL = [String]()
    
    var firstDate = String()
    var secondDate = String()

    var dateRange = [String]()
    var attendances = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! AttendenceHistoryViewController
        DestinationViewController.dateRange = self.dateRange
        DestinationViewController.attendances = self.attendances
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoStudentOfClassSectionTableViewCell", for: indexPath) as! StudentOfClassSectionTableViewCell

        let index = indexPath.row
        cell.lbl_userName.text = studentNames[index]
        cell.sStudentID = studentIDs[index]
        cell.firstDate = self.firstDate
        cell.secondDate = self.secondDate
        if self.studenImgURL[index].count > 4 {
            let photourl = GlobalConst.glb_studentImg_path + self.studenImgURL[index]
            let session = URLSession(configuration: .default)
            let url = URL(string: photourl)!
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    DispatchQueue.main.async{
                        cell.img_userPhoto.image = UIImage(named: "ic_userPhoto")
                    }
                } else {
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded cat picture with response code \(res.statusCode)")
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            if ((image?.size) != nil){
                                DispatchQueue.main.async{
                                    if let updateCell = tableView.cellForRow(at: indexPath){
                                        let cell = updateCell as! StudentOfClassSectionTableViewCell
                                        cell.img_userPhoto?.image = image
                                        cell.img_userPhoto.layer.borderWidth=1.0
                                        cell.img_userPhoto.layer.masksToBounds = false
                                        cell.img_userPhoto.layer.borderColor = UIColor.white.cgColor
                                        cell.img_userPhoto.layer.cornerRadius = cell.img_userPhoto.frame.size.height/2
                                        cell.img_userPhoto.clipsToBounds = true
                                        
                                    } else {
                                        DispatchQueue.main.async{
                                            cell.img_userPhoto.image = UIImage(named: "ic_userPhoto")
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async{
                                    cell.img_userPhoto.image = UIImage(named: "ic_userPhoto")
                                }
                            }
                        } else {
                            DispatchQueue.main.async{
                                cell.img_userPhoto.image = UIImage(named: "ic_userPhoto")
                            }
                        }
                    } else {
                        DispatchQueue.main.async{
                            cell.img_userPhoto.image = UIImage(named: "ic_userPhoto")
                        }
                    }
                }
            }
            downloadPicTask.resume()
        }
        return cell
    }
 


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getResultFromServer(index: indexPath.row)
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    func getResultFromServer(index: Int){
        dateRange.removeAll()
        attendances.removeAll()
        
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let student_id: String = self.studentIDs[index]
        let date_start: String = self.firstDate
        let date_end: String = self.secondDate
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_student_specific_attendance")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&student_id=\(student_id)&date_start=\(date_start)&date_end=\(date_end)"
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
                        let date = result["date"] as! String
                        self.dateRange.append(date)
                        let att = result["att"] as! [String:Any]
                        let attendance_id = att["attendance_id"] as? String
                        if attendance_id == nil{
                            self.attendances.append("0")
                        } else {
                            self.attendances.append(attendance_id!)
                        }
                    }
                }
                self.showResult()
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func showResult(){
        DispatchQueue.main.async(execute: {
            self.performSegue(withIdentifier: "gotoAlert", sender: self)
        })
    }
}
