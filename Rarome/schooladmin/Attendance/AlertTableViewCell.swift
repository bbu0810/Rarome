//
//  AlertTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/18/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view_top: UIView!
    
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_attendance: UILabel!
    
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
