//
//  MedicalRecordTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/4/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class MedicalRecordTableViewCell: UITableViewCell, UITableViewDataSource {
    @IBOutlet weak var lbl_immunizationRecordTitle: UILabel!
    @IBOutlet weak var btn_immunizationReport: UIButton!
    
    @IBOutlet weak var lbl_medicalProblem: UILabel!
    @IBOutlet weak var lbl_description: UILabel!
    @IBOutlet weak var lbl_consultingType: UILabel!
    @IBOutlet weak var lbl_diagnosis: UILabel!
    
    @IBOutlet weak var tbl_medicalHistory: UITableView!
    
    var sImmunizationURL: String!
    
    var sMedicalProblem: String!
    var sDescription: String!
    var sConsultingType: String!
    var sDiagnosis: String!
    
    var sDiseases: [String]?
    var sDates: [String]?
    var sDescriptions: [String]?
    var sprescriptions: [String]?
    
    class var expendedHeight: CGFloat{ get{return 700}}
    class var defaultHeight: CGFloat{ get{return 50}}
    
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < ParentInfoTableCell.expendedHeight)
        if bool == false {
            tbl_medicalHistory.dataSource = self
            tbl_medicalHistory.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDetailMedicalHistoryTableViewCell") as! DetailMedicalHistoryTableViewCell
        cell.lbl_disease.text = sDiseases?[indexPath.row]
        cell.lbl_date.text = sDates?[indexPath.row]
        cell.lbl_description.text = sDescriptions?[indexPath.row]
        cell.lbl_prescription.text = sprescriptions?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sDiseases!.count
    }
    
}
