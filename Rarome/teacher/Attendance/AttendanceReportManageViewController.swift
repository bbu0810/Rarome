//
//  AttendanceReportManageViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/18/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AttendanceReportManageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var tbl_attendance: UITableView!
    
    var sStudentNames = [String]()
    var sStudentIds = [String]()
    var sStudentImgUrl = [String]()
    
    var sMonth = String()
    var sTitle = String()
    
    static var selectedItem = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.text = sTitle
        tbl_attendance.dataSource = self
        tbl_attendance.delegate = self
        print(sStudentNames)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoAttendanceTable") as! AttendanceRepportManageTableViewCell
        cell.lbl_userName.text = sStudentNames[indexPath.row]
        cell.indext = indexPath.row
        cell.accessoryType = UITableViewCellAccessoryType.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sStudentNames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "gotoDetailAttendanceReporte", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestinationViewController = segue.destination as! AttendanceHistoryViewController
        DestinationViewController.sMonth = self.sMonth
        DestinationViewController.sStudent_id = self.sStudentIds[AttendanceReportManageViewController.selectedItem]
    }

}
