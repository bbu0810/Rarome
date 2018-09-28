//
//  EducationDetailViewTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/22/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class EducationDetailViewTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_course: UILabel!
    @IBOutlet weak var lbl_institution: UILabel!
    @IBOutlet weak var lbl_percentage: UILabel!
    @IBOutlet weak var lbl_courseFrom: UILabel!
    @IBOutlet weak var lbl_courseTo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
