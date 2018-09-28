//
//  TeacherDashboardViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/28/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class TeacherDashboardViewController: UIViewController {

    var date_from = [String]()
    var date_to = [String]()
    var total_leaves = [String]()
    var leave_taken = [String]()
    var reason = [String]()
    var comment = [String]()
    var final_approve = [String]()
    
    let processDialog = MyProcessDialogViewController(message: "Loading...")
    let lbl_userName = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indertButtonsInNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        let sUsernsme = UserDefaults.standard.string(forKey: "sName")
        self.navigationItem.setHidesBackButton(true, animated:true)
        lbl_userName.text = sUsernsme
        lbl_userName.textColor = UIColor.white
        let leftItem = UIBarButtonItem(customView: lbl_userName)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(false, animated:true)
        self.lbl_userName.removeFromSuperview()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "gotoLeaves":
            var DestinationViewController = segue.destination as! LeavesTableViewController
            LeavesTableViewController.dateFrom = date_from
            LeavesTableViewController.dateTo = date_to
            LeavesTableViewController.availableleaves = total_leaves
            LeavesTableViewController.leavesTaken = leave_taken
            LeavesTableViewController.comment = comment
            LeavesTableViewController.reason = reason
            LeavesTableViewController.pending = final_approve
        default:
            break
        }
    }
    
    @IBAction func onClickMessage(_ sender: UIButton, forEvent event: UIEvent) {
    }

    @IBAction func onClickLeaves(_ sender: UIButton, forEvent event: UIEvent) {
        date_from.removeAll()
        date_to.removeAll()
        total_leaves.removeAll()
        leave_taken.removeAll()
        reason.removeAll()
        comment.removeAll()
        final_approve.removeAll()
        
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        
        present(processDialog, animated: true, completion: nil)
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_applied_leaves")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var sDeviceToken: String = ""
        var iDeviceID: String = (UIDevice.current.identifierForVendor?.uuidString)!
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)"
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
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }

            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let iStatus = parseData["status"] as! Int
                let sMessage = parseData["message"] as! String
                if iStatus == 1 {
                    let leaves = parseData["leaves"] as? [[String: Any]]
                    for leave in leaves! {
                        let dataFrom = leave["date_from"] as? String
                        let dataTo = leave["date_to"] as? String
                        let totalLeaves = leave["total_leaves"] as? String
                        let leave_taken = leave["leave_taken"] as? String
                        let reason = leave["reason"] as? String
                        let comment = leave["approve_supervisor_comment1"] as? String
                        let final_approve = leave["final_approve"] as? String
                        self.date_from.append(dataFrom!)
                        self.date_to.append(dataTo!)
                        self.total_leaves.append(totalLeaves!)
                        self.leave_taken.append(leave_taken!)
                        self.reason.append(reason!)
                        self.comment.append(final_approve!)
                        self.final_approve.append(final_approve!)
                    }
                    DispatchQueue.main.async(execute: {
                        self.processDialog.dismiss(animated: true, completion: nil)
                        self.performSegue(withIdentifier: "gotoLeaves", sender: self)
                    })
                }
            } catch let error as NSError {
                print(error)
                DispatchQueue.main.async(execute: {
                    self.processDialog.dismiss(animated: true, completion: nil)
                })
            }
        }
        task.resume()
    }

    @IBAction func onClickProgressReport(_ sender: UIButton, forEvent event: UIEvent) {
    }

    @IBAction func onClickAttendance(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickAssignment(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickHomeWork(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickViewPayslip(_ sender: UIButton, forEvent event: UIEvent) {
    }
    @IBAction func onClickStudentsInfo(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    func indertButtonsInNavigation(){
        if let navigationBar = self.navigationController?.navigationBar{
            
            let btn_profile = UIButton(type: UIButtonType.custom)
            let btn_messages = UIButton(type: UIButtonType.custom)
            let btn_logout = UIButton(type: UIButtonType.custom)
            btn_profile.setImage(UIImage(named: "ic_person"), for: UIControlState.normal)
            btn_messages.setImage(UIImage(named: "ic_notifications"), for: UIControlState.normal)
            btn_logout.setImage(UIImage(named: "ic_logout"), for: UIControlState.normal)
            btn_profile.addTarget(self, action: #selector(AdminDashboardViewController.onClick_profile), for: UIControlEvents.touchDown)
            btn_messages.addTarget(self, action: #selector(AdminDashboardViewController.onClick_message), for: UIControlEvents.touchDown)
            btn_logout.addTarget(self, action: #selector(AdminDashboardViewController.onClick_logout), for: UIControlEvents.touchDown)
            btn_profile.frame=CGRect(x: 0, y: 0, width: 30,  height: navigationBar.frame.height)
            btn_messages.frame=CGRect(x: 0, y: 0, width: 30,  height: navigationBar.frame.height)
            btn_logout.frame=CGRect(x: 0, y: 0, width: 30,  height: navigationBar.frame.height)
            let barProfile = UIBarButtonItem(customView: btn_profile)
            let barMessage = UIBarButtonItem(customView: btn_messages)
            let barLogout = UIBarButtonItem(customView: btn_logout)
            self.navigationItem.rightBarButtonItems = [barLogout, barProfile, barMessage]
        }
    }
    func onClick_logout(){
    }
    func onClick_profile(){
        self.performSegue(withIdentifier: "gotoProfileFromTeacherPanel", sender: self)
    }
    func onClick_message(){
        self.performSegue(withIdentifier: "gotoMessgeBoxViewController", sender: self)
    }
}
