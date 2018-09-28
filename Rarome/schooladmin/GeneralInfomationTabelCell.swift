//
//  GeneralInfomationTabelCell.swift
//  Rarome
//
//  Created by AntonDream on 8/2/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class GeneralInfomationTabelCell: UITableViewCell{
    
    @IBOutlet weak var imgView_userPhoto: UIImageView!
    @IBOutlet weak var lbl_userName: UILabel!
    @IBOutlet weak var lbl_grade: UILabel!
    @IBOutlet weak var lbl_section: UILabel!
    @IBOutlet weak var lbl_Roll: UILabel!
    @IBOutlet weak var lbl_enrollmentDate: UILabel!
    @IBOutlet weak var lbl_iCardNumber: UILabel!
    @IBOutlet weak var lbl_previousSchool: UILabel!
    @IBOutlet weak var lbl_course: UILabel!
    @IBOutlet weak var lbl_passportNumber: UILabel!
    @IBOutlet weak var lbl_gender: UILabel!
    @IBOutlet weak var lbl_dateOfBirth: UILabel!
    @IBOutlet weak var lbl_age: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_send: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_emergencyContantNumber: UILabel!
    @IBOutlet weak var lbl_nameOfEmergencyContact: UILabel!
    @IBOutlet weak var lbl_relationOfEmergencyContactWithChild: UILabel!
    @IBOutlet weak var lbl_adress: UILabel!
    @IBOutlet weak var lbl_placeOfBirth: UILabel!
    @IBOutlet weak var lbl_country: UILabel!
    

    @IBOutlet weak var hid1: UIStackView!
    @IBOutlet weak var hid2: UILabel!
    @IBOutlet weak var hid3: UILabel!
    @IBOutlet weak var hid4: UILabel!
    @IBOutlet weak var hid5: UILabel!
    @IBOutlet weak var hid6: UILabel!
    @IBOutlet weak var hid7: UILabel!
    @IBOutlet weak var hid8: UILabel!
    @IBOutlet weak var hid9: UILabel!
    @IBOutlet weak var hid10: UILabel!
    @IBOutlet weak var hid11: UILabel!
    @IBOutlet weak var hid12: UILabel!
    @IBOutlet weak var hid13: UILabel!
    @IBOutlet weak var hid14: UILabel!
    @IBOutlet weak var hid15: UIStackView!
    @IBOutlet weak var hid16: UILabel!
    @IBOutlet weak var hid17: UILabel!
    @IBOutlet weak var hid18: UITextView!
    @IBOutlet weak var hid19: UITextView!
    @IBOutlet weak var hid20: UITextView!
    @IBOutlet weak var hid21: UIStackView!
    @IBOutlet weak var hid22: UILabel!
    @IBOutlet weak var hid23: UILabel!
    @IBOutlet weak var hid24: UILabel!

    
    class var expendedHeight: CGFloat{ get{return 1000}}
    class var defaultHeight: CGFloat{ get{return 50}}
    
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < GeneralInfomationTabelCell.expendedHeight)
   //     hidden(bool: bool)
    }
    
    func watchFrameChanges(){
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges(){
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    func hidden(bool: Bool){
        imgView_userPhoto.isHidden = bool
        lbl_userName.isHidden = bool
        lbl_grade.isHidden = bool
        lbl_section.isHidden = bool
        lbl_Roll.isHidden = bool
        lbl_enrollmentDate.isHidden = bool
        lbl_iCardNumber.isHidden = bool
        lbl_previousSchool.isHidden = bool
        lbl_course.isHidden = bool
        lbl_passportNumber.isHidden = bool
        lbl_gender.isHidden = bool
        lbl_dateOfBirth.isHidden = bool
        lbl_age.isHidden = bool
        lbl_status.isHidden = bool
        lbl_send.isHidden = bool
        lbl_phone.isHidden = bool
        lbl_email.isHidden = bool
        lbl_emergencyContantNumber.isHidden = bool
        lbl_nameOfEmergencyContact.isHidden = bool
        lbl_relationOfEmergencyContactWithChild.isHidden = bool
        lbl_adress.isHidden = bool
        lbl_placeOfBirth.isHidden = bool
        lbl_country.isHidden = bool
        hid1.isHidden = bool
        hid2.isHidden = bool
        hid3.isHidden = bool
        hid4.isHidden = bool
        hid5.isHidden = bool
        hid6.isHidden = bool
        hid7.isHidden = bool
        hid8.isHidden = bool
        hid9.isHidden = bool
        hid10.isHidden = bool
        hid11.isHidden = bool
        hid12.isHidden = bool
        hid13.isHidden = bool
        hid14.isHidden = bool
        hid15.isHidden = bool
        hid16.isHidden = bool
        hid17.isHidden = bool
        hid18.isHidden = bool
        hid19.isHidden = bool
        hid20.isHidden = bool
        hid21.isHidden = bool
        hid22.isHidden = bool
        hid23.isHidden = bool
        hid24.isHidden = bool
    }
}
