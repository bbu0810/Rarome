//
//  HostelFeeTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 9/13/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class HostelFeeTableViewCell: UITableViewCell, UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var feeOfTerms: UITableView!
    @IBOutlet weak var view_top: UIView!
    
    var sHostelFee_termName = [String]()
    var sHostelFee_label = [String]()
    var sHostelFee_termAmount = [String]()
    var sHostelFee_scholarship = [Int]()
    var sHostelFee_concession = [Int]()
    var sHostelFee_fine = [Int]()
    var sHostelFee_total = [Int]()
    var sHostelFee_totalPaid = [Int]()
    var sHostelFee_netDue = [Int]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feeOfTerms.delegate = self
        feeOfTerms.dataSource = self
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
        return self.sHostelFee_termName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoHostelTermFeeTableViewCell") as! HostelTermFeeTableViewCell
        cell.lbl_termName.text = sHostelFee_termName[indexPath.row]
        cell.lbl_due.text = sHostelFee_label[indexPath.row]
        cell.lbl_amount.text = sHostelFee_termAmount[indexPath.row]
        cell.lbl_scholarship.text = String(sHostelFee_scholarship[indexPath.row])
        cell.lbl_concession.text = String(sHostelFee_concession[indexPath.row])
        cell.lbl_fine.text = String(sHostelFee_fine[indexPath.row])
        cell.lbl_total.text = String(sHostelFee_total[indexPath.row])
        cell.lbl_totalPaid.text = String(sHostelFee_totalPaid[indexPath.row])
        cell.lbl_netDue.text = String(sHostelFee_netDue[indexPath.row])
        return cell
    }
}
