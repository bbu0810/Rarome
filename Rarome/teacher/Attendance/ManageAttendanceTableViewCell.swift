//
//  ManageAttendanceTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/15/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
protocol ManageAttendanceTableViewCellDelegate: AnyObject{
    func didTapButton(index: Int)
}
class ManageAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var img_userPhoto: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var view_btn: UIView!
    @IBOutlet weak var btn_absent: UIButton!
    var index = Int()
    var delegate: ManageAttendanceTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    @IBAction func onButtonAction(_ sender: UIButton, forEvent event: UIEvent) {
                delegate?.didTapButton(index: index)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    } 
    
//    @IBAction func onClick_attendanceStatu(_ sender: UIButton, forEvent event: UIEvent) {
//        if sStatus[index] == "0" {
//            let img_selected = UIImage(named: "btn_presentSelected");
//            sender.setImage(img_selected, for: .normal)
//            sStatus[index] = "1"
//        } else {
//            let img_unSelected = UIImage(named: "btn_absentUnselect")
//            sender.setImage(img_unSelected, for: .normal)
//            sStatus[index] = "0"
//        }
//    }
}
