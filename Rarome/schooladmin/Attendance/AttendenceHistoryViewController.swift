//
//  AttendenceHistoryViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/18/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AttendenceHistoryViewController: UIViewController, UITableViewDataSource{
    var dateRange = [String]()
    var attendances = [String]()
    
    @IBOutlet weak var tbl_AttendanceHistory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl_AttendanceHistory.dataSource = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func onClick_out(_ sender: UIButton, forEvent event: UIEvent) {
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateRange.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoAttendaceHistoryCell") as? AlertTableViewCell
        cell?.lbl_date.text = dateRange[indexPath.row]
        cell?.lbl_attendance.text = "Absent"
        cell?.lbl_attendance.textColor = UIColor.red
        if attendances[indexPath.row] == "1"{
            cell?.lbl_attendance.textColor = UIColor.green
            cell?.lbl_attendance.text = "Present"
        }
        return cell!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

}
