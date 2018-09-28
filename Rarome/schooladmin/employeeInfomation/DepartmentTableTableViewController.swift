//
//  DepartmentTableTableViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/6/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class DepartmentTableTableViewController: UITableViewController {

    var sEmployeeNames = [String]()
    var sEmployeeFirstName = [String]()
    var sEmployeeLastName = [String]()
    var sEmployeeIDs = [String]()
    
    var selectedIndexPath: IndexPath?

    var sEmail = [String]()
    var sDateOfBirthday = [String]()
    var sGender = [String]()
    var sYearsOfExp = [String]()
    var sRoleName = [String]()
    var sDateOfJoning = [String]()
    var sPhoneNumber = [String]()
    var sSalar = [String]()
    var sLeave = [String]()
    var sHomeNumber = [String]()
    var sAddress = [String]()
    var sBankName = [String]()
    var sBankRecordName = [String]()
    var sAccounttype = [String]()
    var sAccountNo = [String]()
    var sBankAccountRef = [String]()
    var sStatus = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = GlobalConst.glb_selectedID
        GlobalConst.glb_sEmployeeName = sEmployeeNames[index!]
        GlobalConst.glb_sEmployeeFirstName = sEmployeeFirstName[index!]
        GlobalConst.glb_sEmployeeLastName = sEmployeeLastName[index!]
        GlobalConst.glb_sEmployeeID = sEmployeeIDs[index!]
        GlobalConst.glb_sEmail = sEmail[index!]
        GlobalConst.glb_sDateOfBirthday = sDateOfBirthday[index!]
        GlobalConst.glb_sGender = sGender[index!]
        GlobalConst.glb_sYearsOfExp = sYearsOfExp[index!]
        GlobalConst.glb_RoleName = sRoleName[index!]
        GlobalConst.glb_sDateOfJoning = sDateOfJoning[index!]
        GlobalConst.glb_sPhoneNumber = sPhoneNumber[index!]
        GlobalConst.glb_sSalar = sSalar[index!]
        GlobalConst.glb_sLeave = sLeave[index!]
        GlobalConst.glb_homeNumber = sHomeNumber[index!]
        GlobalConst.glb_sAddress = sAddress[index!]
        GlobalConst.glb_sBankName = sBankName[index!]
        GlobalConst.glb_sBankrecordName = sBankRecordName[index!]
        GlobalConst.glb_sAccountNo = sAccountNo[index!]
        GlobalConst.glb_sBankAccountRef = sBankAccountRef[index!]
        GlobalConst.glb_sStatus = sStatus[index!]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sEmployeeNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDetailDepartmentEmployeesTableViewCell", for: indexPath) as! DetailDepartmentEmployeesTableVIewCell
        let index = indexPath.row
        cell.iNumber = index
        cell.lbl_name.text = self.sEmployeeNames[index]
        cell.view_cell.layer.borderWidth = 1
        cell.view_cell.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath{
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        tableView.reloadData()
        var indexPaths: Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
