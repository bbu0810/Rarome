//
//  UpdateStudentsAttendanceViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/15/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
var sStatus = [String]()
var btnStatus = [UIButton]()
class UpdateStudentsAttendanceViewController: UIViewController, UITableViewDataSource{

    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var edt_RFID: UITextField!
    @IBOutlet weak var btn_validate: UIButton!
    @IBOutlet weak var tbl_students: UITableView!
    
    var sStudentsName = [String]()
    var sStudentIds = [String]()
    var sStudentImgUrl = [String]()
    var sStudentAttendaceStatu = [String]()
    var sTitle = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl_title.text = sTitle
        tbl_students.dataSource = self
        tbl_students.frame.size.height = CGFloat(70 * sStudentsName.count)
        for _ in 0..<sStudentsName.count{
            sStatus.append("0")
            btnStatus.append(UIButton())
            let btn = UIButton()
//            btn.addTarget(self, action: "buttonClicked:", for: .touchUpInside)
//            btn.addTarget(self, action: #selector(UpdateStudentsAttendanceViewController.buttonClicked), for: UIControlEvents.touchDown)
            btnStatus.append(btn)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoManageAttendanceTableCell") as! ManageAttendanceTableViewCell
        cell.lbl_userName.text = sStudentsName[indexPath.row]
        cell.btn_attendanceStatus = btnStatus[indexPath.row]
        cell.index = indexPath.row
        cell.accessoryType = UITableViewCellAccessoryType.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sStudentsName.count
    }
    
    func buttonClicked() {
//        if sender?.isSelected == true {
//            let img_unSelected = UIImage(named: "btn_absentUnselect")
//            sender?.setImage(img_unSelected, for: .normal)
//            sender?.isSelected = false
//        } else {
//            let img_selected = UIImage(named: "btn_presentSelected");
//            sender?.setImage(img_selected, for: .normal)
//        }
        var i = 90
    }
}
