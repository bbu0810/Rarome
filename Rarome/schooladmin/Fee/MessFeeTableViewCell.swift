//
//  MessFeeTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/13/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class MessFeeTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tbl_messFee: UITableView!
    @IBOutlet weak var view_top: UIView!
    
    var sMessFee_termName = [String]()
    var sMessFee_label = [String]()
    var sMessFee_termAmount = [String]()
    var sMessFee_scholarship = [Int]()
    var sMessFee_concession = [Int]()
    var sMessFee_fine = [Int]()
    var sMessFee_total = [Int]()
    var sMessFee_totalPaid = [Int]()
    var sMessFee_netDue = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tbl_messFee.delegate = self
        tbl_messFee.dataSource = self
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
        return self.sMessFee_termName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoMessTermFeeTableViewCell") as! MessTermFeeTableViewCell
        cell.lbl_termName.text = sMessFee_termName[indexPath.row]
        cell.lbl_due.text = sMessFee_label[indexPath.row]
        cell.lbl_amount.text = sMessFee_termAmount[indexPath.row]
        cell.lbl_scholarship.text = String(sMessFee_scholarship[indexPath.row])
        cell.lbl_concession.text = String(sMessFee_concession[indexPath.row])
        cell.lbl_fine.text = String(sMessFee_fine[indexPath.row])
        cell.lbl_total.text = String(sMessFee_total[indexPath.row])
        cell.lbl_totalPaid.text = String(sMessFee_totalPaid[indexPath.row])
        cell.lbl_netDue.text = String(sMessFee_netDue[indexPath.row])
        return cell
    }
    
}
