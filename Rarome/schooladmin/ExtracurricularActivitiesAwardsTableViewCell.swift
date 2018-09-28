//
//  ExtracurricularActivitiesAwardsTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/3/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class ExtracurricularActivitiesAwardsTableViewCell: UITableViewCell, UITableViewDataSource{

    @IBOutlet weak var lbl_Extracurricular: UITableView!
    
    var sExtracurricularCertificates: [String]?
    var sIssueDates: [String]?
    
    class var expendedHeight: CGFloat{ get{return 330}}
    class var defaultHeight: CGFloat{ get{return 50}}
    
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < ParentInfoTableCell.expendedHeight)
        if bool == false {
            lbl_Extracurricular.isHidden = false
            lbl_Extracurricular.dataSource = self
            lbl_Extracurricular.reloadData()
        } else {
            lbl_Extracurricular.isHidden = true
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDetailExtracurricularTableViewCell") as! DetailExtracurricularTableViewCell
        cell.lbl_ExtracurricularCertificate.text = sExtracurricularCertificates?[indexPath.row]
        cell.lbl_issueDate.text = sIssueDates?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sExtracurricularCertificates!.count
    }
    
}
