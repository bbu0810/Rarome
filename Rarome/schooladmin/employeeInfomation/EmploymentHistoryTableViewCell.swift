//
//  EmploymentHistoryTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/14/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import TextFieldEffects
import DatePickerDialog
class EmploymentHistoryTableViewCell: UITableViewCell{
    @IBOutlet weak var txt_company: HoshiTextField!
    @IBOutlet weak var txt_website: HoshiTextField!
    @IBOutlet weak var txt_designation: HoshiTextField!
    
    @IBOutlet weak var view_companyFrom: UIView!
    @IBOutlet weak var btn_companyFrom: UIButton!

    @IBOutlet weak var view_companyTo: UIView!
    @IBOutlet weak var btn_companyTo: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_companyFrom.layer.borderWidth = 1
        view_companyFrom.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_companyTo.layer.borderWidth = 1
        view_companyTo.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClick_companyFrom(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_companyTo(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_delete(_ sender: UIButton, forEvent event: UIEvent) {
                EmployeeProfileUpdateViewController.count_employeeHistoryTableCells = EmployeeProfileUpdateViewController.count_employeeHistoryTableCells - 1
        self.removeFromSuperview()
    }
    
    func datePickerTapped(button: UIButton) {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let date = formatter.string(from: dt)
                button.setTitle(date, for: .normal)
            }
        }
    }
}
