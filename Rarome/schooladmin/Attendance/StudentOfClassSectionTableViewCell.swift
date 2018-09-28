//
//  StudentOfClassSectionTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/17/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class StudentOfClassSectionTableViewCell: UITableViewCell {

    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var img_userPhoto: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    
    var sStudentID = String()
    var firstDate = String()
    var secondDate = String()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
}
