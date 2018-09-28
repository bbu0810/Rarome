//
//  SchoolFeeTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/13/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class SchoolFeeTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbl_feeOfTerms: UITableView!
    @IBOutlet weak var view_top: UIView!
    
    var sSchoolFee_termName = [String]()
    var sSchoolFee_label = [String]()
    var sSchoolFee_termAmount = [String]()
    var sSchoolFee_scholarship = [Int]()
    var sSchoolFee_Concession = [Int]()
    var sSchoolFee_Fine = [Int]()
    var sSchoolFee_total = [Int]()
    var sSchoolFee_totalPaid = [Int]()
    var sSchoolFee_netDue = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tbl_feeOfTerms.delegate = self
        tbl_feeOfTerms.dataSource = self
        // Initialization code
        view_top.layer.borderWidth = 1
        view_top.layer.cornerRadius = 5
        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sSchoolFee_termName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoSchoolTermFeeTableViewCell") as! SchoolTerFeeTableViewCell
        cell.lbl_termName.text = sSchoolFee_termName[indexPath.row]
        cell.lbl_due.text = sSchoolFee_label[indexPath.row]
        cell.lbl_amount.text = sSchoolFee_termAmount[indexPath.row]
        cell.lbl_scholarship.text = String(sSchoolFee_scholarship[indexPath.row])
        cell.lbl_concession.text = String(sSchoolFee_Concession[indexPath.row])
        cell.lbl_fine.text = String(sSchoolFee_Fine[indexPath.row])
        cell.lbl_total.text = String(sSchoolFee_total[indexPath.row])
        cell.lbl_totalPaid.text = String(sSchoolFee_totalPaid[indexPath.row])
        cell.lbl_netDue.text = String(sSchoolFee_netDue[indexPath.row])
            return cell
    }    
}
