//
//  HostelTermFeeTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/13/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class HostelTermFeeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_termName: UILabel!
    @IBOutlet weak var lbl_due: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_scholarship: UILabel!
    @IBOutlet weak var lbl_concession: UILabel!
    @IBOutlet weak var lbl_fine: UILabel!
    @IBOutlet weak var lbl_total: UILabel!
    @IBOutlet weak var lbl_totalPaid: UILabel!
    @IBOutlet weak var lbl_netDue: UILabel!    
    
    @IBOutlet weak var view_top: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 1, green: 114/255, blue: 114/225, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
