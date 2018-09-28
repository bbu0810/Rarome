//
//  DomitoryInformationTableCell.swift
//  Rarome
//
//  Created by AntonDream on 8/2/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class DomitoryInformationTableCell: UITableViewCell{
    
    @IBOutlet weak var lbl_hostelName: UILabel!
    @IBOutlet weak var lbl_type: UILabel!
    @IBOutlet weak var lbl_floorName: UILabel!
    @IBOutlet weak var lbl_roomNo: UILabel!
    @IBOutlet weak var lbl_food: UILabel!
    @IBOutlet weak var lbl_registeraionDate: UILabel!
    @IBOutlet weak var lbl_vocationDate: UILabel!
    @IBOutlet weak var lbl_transferDate: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    
    @IBOutlet weak var label_hostelName: UILabel!
    @IBOutlet weak var label_type: UILabel!
    @IBOutlet weak var label_floorName: UILabel!
    @IBOutlet weak var label_roomNo: UILabel!
    @IBOutlet weak var label_food: UILabel!
    @IBOutlet weak var label_registerationDate: UILabel!
    @IBOutlet weak var label_vacatingDate: UILabel!
    @IBOutlet weak var label_transferDate: UILabel!
    @IBOutlet weak var label_status: UILabel!

    
    class var expendedHeight: CGFloat{ get{return 330}}
    class var defaultHeight: CGFloat{ get{return 50}}
    
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < ParentInfoTableCell.expendedHeight)
        if bool != false {
            lbl_hostelName.isHidden = true
            lbl_type.isHidden = true
            lbl_floorName.isHidden = true
            lbl_roomNo.isHidden = true
            lbl_food.isHidden = true
            lbl_registeraionDate.isHidden = true
            lbl_vocationDate.isHidden = true
            lbl_transferDate.isHidden = true
            lbl_status.isHidden = true
            label_hostelName.isHidden = true
            label_type.isHidden = true
            label_floorName.isHidden = true
            label_roomNo.isHidden = true
            label_food.isHidden = true
            label_registerationDate.isHidden = true
            label_vacatingDate.isHidden = true
            label_transferDate.isHidden = true
            label_status.isHidden = true
        } else {
            lbl_hostelName.isHidden = false
            lbl_type.isHidden = false
            lbl_floorName.isHidden = false
            lbl_roomNo.isHidden = false
            lbl_food.isHidden = false
            lbl_registeraionDate.isHidden = false
            lbl_vocationDate.isHidden = false
            lbl_transferDate.isHidden = false
            lbl_status.isHidden = false
            label_hostelName.isHidden = false
            label_type.isHidden = false
            label_floorName.isHidden = false
            label_roomNo.isHidden = false
            label_food.isHidden = false
            label_registerationDate.isHidden = false
            label_vacatingDate.isHidden = false
            label_transferDate.isHidden = false
            label_status.isHidden = false
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
}
