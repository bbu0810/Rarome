//
//  DailyAttendanceTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/20/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class DailyAttendanceTableViewCell: UITableViewCell {

    @IBOutlet weak var view_top: UIView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_in_time: UILabel!
    @IBOutlet weak var lbl_out_time: UILabel!
    @IBOutlet weak var lbl_statu: UILabel!
    @IBOutlet weak var img_uerPhoto: UIImageView!
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
