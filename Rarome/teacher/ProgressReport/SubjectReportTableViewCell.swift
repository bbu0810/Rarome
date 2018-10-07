//
//  SubjectReportTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/4/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import StarReview
class SubjectReportTableViewCell: UITableViewCell, UITextViewDelegate{
    
    @IBOutlet weak var vuew_top: UIView!
    @IBOutlet weak var img_userPhoto: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var view_starReview: UIView!
    @IBOutlet weak var txt_comments: UITextView!
    @IBOutlet weak var btn_viewHistory: UIButton!
    
    var sStudentID = String()
    var sClassID = String()
    var sSectionID = String()
    var star = StarReview()
    var value = Float(0)
    var index = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buildUI()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txt_comments.resignFirstResponder()
        return(true)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = txt_comments.text.count > 0
            descriptions[index] = txt_comments.text
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func onClick_detail(_ sender: UIButton, forEvent event: UIEvent) {
        GlobalConst.glb_studentID = self.sStudentID
    }
    
    func buildUI(){
        vuew_top.layer.borderWidth = 1
        vuew_top.layer.cornerRadius = 5
        vuew_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        txt_comments.layer.borderWidth = 1
        txt_comments.layer.cornerRadius = 5
        txt_comments.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = "Comments"
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        placeholderLabel.isHidden = txt_comments.text.count > 0
        placeholderLabel.backgroundColor = UIColor.cyan
        
        txt_comments.addSubview(placeholderLabel)
        txt_comments.delegate = self
        
        let x = view_starReview.layer.position.x
        let y = view_starReview.layer.position.y
        star.frame = CGRect(x:x + 8, y: y + 15, width: 100, height: 50)
        star.starMarginScale = 0.3
        star.value = 0
        star.starCount = 5
        star.allowEdit = true
        star.allowAccruteStars = true
        star.starFillColor = UIColor.orange
        star.starBackgroundColor = UIColor.lightGray
        star.addTarget(self, action: #selector(onAddProgreeReport(_:)), for: UIControlEvents.valueChanged) // add the star value change event
        self.contentView.addSubview(star)
    }
    
    func onAddProgreeReport(_ sender: StarReview){
        self.value = sender.value
        starRatings[index] = sender.value
        
        if(sender.value < 2)
        {
            star.starFillColor = UIColor.red
        }
        else if(sender.value < 3)
        {
            star.starFillColor = UIColor.orange
        }
        else if(sender.value < 4)
        {
            star.starFillColor = UIColor.blue
        }
        else if(sender.value < 5)
        {
            star.starFillColor = UIColor.yellow
        }
        else {
            star.starFillColor = UIColor.green
        }
    }
}
