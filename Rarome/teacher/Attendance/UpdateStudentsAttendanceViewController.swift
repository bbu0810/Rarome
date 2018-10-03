//
//  UpdateStudentsAttendanceViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/15/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
var strButtonStatus = [String]()
var btnList = [UIButton]()
var imgsOfButton = [UIImage]()
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
        strButtonStatus.removeAll()
        imgsOfButton.removeAll()
        btnList.removeAll()
        for _ in sStudentsName{
            strButtonStatus.append("0")
            let img_unSelected = UIImage(named: "btn_absentUnselect")
            imgsOfButton.append(img_unSelected!)
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 50))
            btn.setImage(img_unSelected, for: .normal)
            btnList.append(btn)
        }
        lbl_title.text = sTitle
        tbl_students.dataSource = self
        tbl_students.frame.size.height = CGFloat(70 * sStudentsName.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoManageAttendanceTableCell", for: indexPath) as! ManageAttendanceTableViewCell
//        guard let cell = tableView.cellForRow(at: indexPath) as? ManageAttendanceTableViewCell else { return }
        
//        cell.accessoryType = .detailDisclosureButton
        cell.lbl_userName.text = sStudentsName[indexPath.row]
        cell.index = indexPath.row
        cell.delegate = self
        cell.view_btn.addSubview(btnList[indexPath.row])
//        cell.btn_attendanceStatus = btnStatus[indexPath.row]
//        cell.btn_attendanceStatus.tag = indexPath.row
        cell.index = indexPath.row
//        cell.accessoryType = UITableViewCellAccessoryType.none
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sStudentsName.count
    }
}

extension UpdateStudentsAttendanceViewController: ManageAttendanceTableViewCellDelegate{
    func didTapButton(index: Int) {
        if strButtonStatus[index] == "0" {
            strButtonStatus[index] = "1"
            let img = UIImage(named: "btn_presentSelected")
            imgsOfButton[index] = img!
            btnList[index].setImage(img, for: .normal)
        } else {
            strButtonStatus[index] = "0"
            let img = UIImage(named: "btn_absentUnselect")
            imgsOfButton[index] = img!
            btnList[index].setImage(img, for: .normal)
        }
        tbl_students.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .none)
    }
}
