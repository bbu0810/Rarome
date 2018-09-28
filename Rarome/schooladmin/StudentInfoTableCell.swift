//
//  StudentInfoTableCell.swift
//  Rarome
//
//  Created by AntonDream on 7/29/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown
class StudentInfoTableCell: UITableViewCell{
    
    var sMenus = ["Update Passcode", "Marksheet", "Documents"]
    var studentid: String!
    var studentImgURL: String!
    
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_fatherName: UILabel!
    @IBOutlet weak var lbl_motherName: UILabel!
    @IBOutlet weak var lbl_gender: UILabel!
    @IBOutlet weak var lbl_emergency: UILabel!
    
    @IBOutlet weak var imgView_userPhoto: UIImageView!
    @IBOutlet weak var view_menu: UIView!
    @IBOutlet weak var view_studentDetailInfo: UIView!
    
    @IBOutlet weak var btn_more: UIButton!
    @IBOutlet weak var btn_eye: UIButton!
    @IBOutlet weak var btn_edit: UIButton!
    @IBOutlet weak var btn_delete: UIButton!
    @IBOutlet weak var btn_disable: UIButton!
    
    class var expendedHeight: CGFloat{ get{return 220}}
    class var defaultHeight: CGFloat{ get{return 50}}
    
    func checkHeight(){
        view_studentDetailInfo.isHidden = (frame.size.height < StudentInfoTableCell.expendedHeight)
    }
    
    func watchFrameChanges(){
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges(){
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    @IBAction func onClick_menu(_ sender: UIButton, forEvent event: UIEvent) {
        let dropDown = DropDown()
        dropDown.anchorView = view_menu
        dropDown.dataSource = self.sMenus
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch(item) {
            case "Update Passcode":
                self.updatePascode()
                break
            case "Marksheet":
                self.marksheet()
                break
            case "Documents":
                self.documents()
                break
            default:
                break
            }
        }
        dropDown.show()
    }
    
    @IBAction func onClick_eye(_ sender: UIButton, forEvent event: UIEvent) {
        GlobalConst.glb_studentID = self.studentid        
    }
    
    @IBAction func onClick_cridt(_ sender: UIButton) {
        
    }

    @IBAction func onClick_delete(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
    
    @IBAction func onClick_disable(_ sender: UIButton, forEvent event: UIEvent) {
        
    }
    
    func updatePascode(){
        let alert = UIAlertController(title: "Update Passcode",
                                      message: "Do you want to update passcode of this student?",
                                      preferredStyle: .alert)
        let submitAction = UIAlertAction(title: "YES", style: .default, handler: { (action) -> Void in
            self.updatePasscodToServer()
        })
         let cancel = UIAlertAction(title: "NO", style: .destructive, handler: { (action) -> Void in })
        alert.addAction(submitAction)
        alert.addAction(cancel)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    func marksheet(){
        
    }
    
    func documents(){
        GlobalConst.glb_studentID = studentid
        UIApplication.shared.keyWindow?.rootViewController?.performSegue(withIdentifier: "gotoStudentDocuments", sender: self)
    }
    
    func updatePasscodToServer(){
        let userid: String = GlobalConst.glb_sUserId
        let usertype: String = GlobalConst.glb_sUserType
        let schoolid: String = GlobalConst.glb_sSchoolID
        let runing_year: String = GlobalConst.glb_sRunning_year
        let sStudentID: String = self.studentid
        let url = URL(string: "https://demo.rarome.com/index.php/?api/student_update_passcode")!
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
