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
    
    class var expendedHeight: CGFloat{ get{return 330}}
    class var defaultHeight: CGFloat{ get{return 50}}
    
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < ParentInfoTableCell.expendedHeight)
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
