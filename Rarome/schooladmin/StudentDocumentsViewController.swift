//
//  StudentDocumentsViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/1/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class StudentDocumentsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var view_transferCertificate: UIView!
    @IBOutlet weak var view_uploadFiles: UIView!
    @IBOutlet weak var tbl_files: UITableView!
    
    var studentID: String!
    
    var titles = [String]()
    var dates = [String]()
    var sizes = [String]()
    var download_links = [String]()
    var url_keys = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        getAllStudentDocuments()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClick_certificate(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
    
    @IBAction func onClick_uploadFiles(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoStudentDocumentCell", for: indexPath) as! StudenDocumentsCell
        cell.lbl_title.text = self.titles[indexPath.row]
        cell.lbl_date.text = self.dates[indexPath.row]
        cell.lbl_size.text = self.sizes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titles.count)
    }
    
    func getAllStudentDocuments(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let sStudentID: String = GlobalConst.glb_studentID
        let url = URL(string: "https://demo.rarome.com/index.php/?api/student_documents_list")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&student_id=\(sStudentID)"
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
                    let sResult = parseData["documents"] as! [[String:AnyObject]]
                    for result in sResult {
                        let sTitle = result["name"] as? String
                        self.titles.append(sTitle!)
                        let sDate = result["issue_date"] as? String
                        self.dates.append(sDate!)
                        let sSize = result["size"] as? String
                        self.sizes.append(sSize!)
                        let sDownloadLinks = result["download_link"] as? String
                        self.download_links.append(sDownloadLinks!)
                        let sUrl_key = result["url_key"] as? String
                        self.url_keys.append(sUrl_key!)
                    }
                }
                self.showResult()
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
    
    func buildUI(){
        view_transferCertificate.layer.borderWidth = 1
        view_transferCertificate.layer.cornerRadius = 5
        view_transferCertificate.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_uploadFiles.layer.borderWidth = 1
        view_uploadFiles.layer.cornerRadius = 5
        view_uploadFiles.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    func showResult(){
        DispatchQueue.main.async {
            self.tbl_files.dataSource = self
            self.tbl_files.reloadData()
        }
    }
}
