//
//  AttendanceHistoryTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 10/3/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AttendanceHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var viewTiop: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAttendanceStatu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewTiop.layer.borderWidth = 1
        viewTiop.layer.cornerRadius = 5
        viewTiop.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
