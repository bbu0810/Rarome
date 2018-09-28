//
//  AttendanceRepportManageTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/18/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AttendanceRepportManageTableViewCell: UITableViewCell {

    @IBOutlet weak var img_userPhoto: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var view_top: UIView!
    
    var indext = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func onClick_item(_ sender: UIButton, forEvent event: UIEvent) {
        AttendanceReportManageViewController.selectedItem = indext
    }
    
}
