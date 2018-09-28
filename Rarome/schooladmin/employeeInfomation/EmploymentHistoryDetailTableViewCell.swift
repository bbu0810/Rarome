//
//  EmploymentHistoryDetailTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/22/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class EmploymentHistoryDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_cmpanyName: UILabel!
    @IBOutlet weak var lbl_website: UILabel!
    @IBOutlet weak var lbl_designation: UILabel!
    @IBOutlet weak var lbl_companyFrom: UILabel!
    @IBOutlet weak var lbl_companyTo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frame.size.height = 250        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
