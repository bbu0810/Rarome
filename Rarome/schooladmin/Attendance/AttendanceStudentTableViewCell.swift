//
//  AttendanceStudentTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/20/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AttendanceStudentTableViewCell: UITableViewCell {


    @IBOutlet weak var lbl_studenName: UILabel!
    @IBOutlet weak var lbl_section: UILabel!
    @IBOutlet weak var view_top: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
