//
//  ApplyLeavesViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/2/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DatePickerDialog
class ApplyLeavesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lbl_availabelleaves: UILabel!
    @IBOutlet weak var btn_from: UIButton!
    @IBOutlet weak var btn_to: UIButton!
    @IBOutlet weak var txt_reason: UITextField!
    @IBOutlet weak var lbl_daysForLeaves: UILabel!
    
    @IBOutlet weak var btn_submit: UIButton!
    
    var dateFrom = Date()
    var dateTo = Date()

    var sDateFrom = String()
    var sDateTo = String()
    var availableLeaves = String()
    var leavesTaken = String()
    var sReason = String()
    var comment = String()
    var padding = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_reason.delegate = self
        buildUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:150), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }

    @IBAction func onClick_btnFrom(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender, mode: 1)
        
    }
    
    @IBAction func onClick_btnTo(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender, mode: 2)
    }
    
    
    @IBAction func onClick_btnSubmit(_ sender: UIButton, forEvent event: UIEvent) {
        if dateFrom < dateTo{
            let school_id = GlobalConst.glb_sSchoolID!
            let running_year = GlobalConst.glb_sRunning_year!
            let user_type = GlobalConst.glb_sUserType!
            let user_id = GlobalConst.glb_sUserId!
            let from_date = btn_from.title(for: .normal) ?? ""
            self.sDateFrom = from_date
            let to_date = btn_to.title(for: .normal) ?? ""
            self.sDateTo = to_date
            let reason = txt_reason.text ?? ""
            self.sReason = reason
            let no_of_days = lbl_daysForLeaves.text ?? ""
            self.leavesTaken = no_of_days

            let url = URL(string: "https://demo.rarome.com/index.php/?api/teacher_apply_leave")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&from_date=\(from_date)&to_date=\(to_date)&reason=\(reason)&no_of_days=\(no_of_days)"
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
                        DispatchQueue.main.async(execute: {
                            
                            var alert = UIAlertController(title: "Result", message: "Success", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                switch action.style{
                                case .default:
                                    self.dismiss(animated: true, completion: nil)
                                    return
                                case .cancel:
                                    self.dismiss(animated: true, completion: nil)
                                    return
                                case .destructive:
                                    self.dismiss(animated: true, completion: nil)
                                    return
                                }}))
                            self.present(alert, animated: true, completion: nil)
                            LeavesTableViewController.dateFrom.append(self.sDateFrom)
                            LeavesTableViewController.dateTo.append(self.sDateTo)
                            LeavesTableViewController.availableleaves.append(self.availableLeaves)
                            LeavesTableViewController.leavesTaken.append(self.leavesTaken)
                            LeavesTableViewController.comment.append(self.comment)
                            LeavesTableViewController.reason.append(self.sReason)
                            LeavesTableViewController.pending.append(self.padding)
                        })
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
            task.resume()
        } else {
            var alert = UIAlertController(title: "Error", message: "Please select exact Date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    return
                case .cancel:
                    return
                case .destructive:
                    return
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func buildUI(){
        btn_submit.layer.cornerRadius = 5
    }
    
    func datePickerTapped(button: UIButton, mode: Int) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let date = formatter.string(from: dt)
                button.setTitle(date, for: .normal)
                if mode == 1 {
                    self.dateFrom = dt
                } else if mode == 2 {
                    self.dateTo = dt                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    let strDateFrom = formatter.string(from: self.dateFrom)
                    let strDateTo = formatter.string(from: self.dateTo)
                    let cal = NSCalendar.current
                    let unit : Set<Calendar.Component> =  [.day]
                    let daysBetween = cal.dateComponents(unit, from: self.dateFrom, to: self.dateTo)
                    let days = daysBetween.day ?? 0
                    let strDays = String(days)
                    self.lbl_daysForLeaves.text = strDays
                }
            }
        }
    }
    func getTeacherLeaves(){
        
    }
}
