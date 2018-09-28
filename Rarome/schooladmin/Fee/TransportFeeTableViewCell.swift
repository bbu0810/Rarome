//
//  TransportFeeTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/13/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class TransportFeeTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tbl_transportFee: UITableView!
    @IBOutlet weak var view_top: UIView!
    
    var sTransportFee_termName = [String]()
    var sTransportFee_label = [String]()
    var sTransportFee_termAmount = [String]()
    var sTransportFee_scholarship = [Int]()
    var sTransportFee_concession = [Int]()
    var sTransportFee_fine = [Int]()
    var sTransportFee_total = [Int]()
    var sTransportFee_totalPaid = [Int]()
    var sTransportFee_netDue = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tbl_transportFee.delegate = self
        tbl_transportFee.dataSource = self
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
        return self.sTransportFee_termName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoTransportFeeTableviewCell") as! TransportTerFeeTableViewCell
        cell.lbl_termName.text = sTransportFee_termName[indexPath.row]
        cell.lbl_due.text = sTransportFee_label[indexPath.row]
        cell.lbl_amount.text = sTransportFee_termAmount[indexPath.row]
        cell.lbl_scholarship.text = String(sTransportFee_scholarship[indexPath.row])
        cell.lbl_concession.text = String(sTransportFee_concession[indexPath.row])
        cell.lbl_fine.text = String(sTransportFee_fine[indexPath.row])
        cell.lbl_total.text = String(sTransportFee_total[indexPath.row])
        cell.lbl_totalPaid.text = String(sTransportFee_totalPaid[indexPath.row])
        cell.lbl_netDue.text = String(sTransportFee_netDue[indexPath.row])
        return cell
    }
}
