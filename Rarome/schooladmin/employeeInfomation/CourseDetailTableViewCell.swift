//
//  CourseDetailTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/14/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import TextFieldEffects
import DatePickerDialog
class CourseDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var txt_course: HoshiTextField!
    @IBOutlet weak var txt_institute: HoshiTextField!
    @IBOutlet weak var txt_percentage: HoshiTextField!
    
    @IBOutlet weak var view_courseFrom: UIView!
    @IBOutlet weak var btn_courseFrom: UIButton!
    
    @IBOutlet weak var view_courseTo: UIView!
    @IBOutlet weak var btn_courseTo: UIButton!
    
    var index: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view_courseFrom.layer.borderWidth = 1
        view_courseFrom.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        view_courseTo.layer.borderWidth = 1
        view_courseTo.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
        // Configure the view for the selected state
    }
    
    @IBAction func onClick_courseFrom(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_courseTo(_ sender: UIButton, forEvent event: UIEvent) {
        datePickerTapped(button: sender)
    }
    
    @IBAction func onClick_delete(_ sender: UIButton, forEvent event: UIEvent) {
        EmployeeProfileUpdateViewController.count_courseTableCells = EmployeeProfileUpdateViewController.count_courseTableCells - 1
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
