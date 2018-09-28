//
//  AttendanceRecordTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/4/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class AttendanceRecordTableViewCell: UITableViewCell, UITableViewDataSource{
    
    
    
    @IBOutlet weak var tbl_attendanceTableView: UITableView!
    var sMonths: [String]!
    var sDays: [Int]!
    var sPercents: [Int]!
    class var expendedHeight: CGFloat{ get{return 710}}
    class var defaultHeight: CGFloat{ get{return 50}}
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < ParentInfoTableCell.expendedHeight)
        if bool == false {
            tbl_attendanceTableView.dataSource = self
            tbl_attendanceTableView.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDetailAttendanceRecordTableviewCell") as! DetailAttendaceRecordTableViewCell
        cell.lbl_month.text = sMonths[indexPath.row]
        cell.lbl_days.text = String(sDays[indexPath.row])
        cell.lbl_percent.text = String(sPercents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sMonths!.count
    }
    
}
