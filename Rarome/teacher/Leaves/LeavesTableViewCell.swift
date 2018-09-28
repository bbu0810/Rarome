//
//  LeavesTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/1/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class LeavesTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_dateFrom: UILabel!
    @IBOutlet weak var lbl_dateTo: UILabel!
    @IBOutlet weak var lbl_availableLeaves: UILabel!
    @IBOutlet weak var lbl_leavesTaken: UILabel!
    @IBOutlet weak var lbl_reason: UILabel!
    @IBOutlet weak var lbl_please: UILabel!
    @IBOutlet weak var lbl_pending: UILabel!
    @IBOutlet weak var view_main: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_main.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_main.layer.cornerRadius = 5
        view_main.layer.borderWidth = 1

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
