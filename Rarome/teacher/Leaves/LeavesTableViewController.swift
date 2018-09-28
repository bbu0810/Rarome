//
//  LeavesTableViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/1/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class LeavesTableViewController: UITableViewController {
    static var dateFrom = [String]()
    static var dateTo = [String]()
    static var availableleaves = [String]()
    static var leavesTaken = [String]()
    static var reason = [String]()
    static var comment = [String]()
    static var pending = [String]()
    
    var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        button = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width - 90, y: self.view.frame.height - 80), size: CGSize(width: 60, height: 60)))
        button.setImage(UIImage(named: "ic_plus"), for: .normal)
        button.addTarget(self, action: #selector(onClickBtnAdd(_:)), for: UIControlEvents.touchUpInside)
    }

    override func viewWillDisappear(_ animated: Bool) {
        button.removeFromSuperview()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.view.addSubview(button)
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LeavesTableViewController.dateFrom.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoLeavesTableViewCell", for: indexPath) as! LeavesTableViewCell
        cell.lbl_dateFrom.text = LeavesTableViewController.dateFrom[indexPath.row]
        cell.lbl_dateTo.text = LeavesTableViewController.dateTo[indexPath.row]
        cell.lbl_availableLeaves.text = LeavesTableViewController.availableleaves[indexPath.row]
        cell.lbl_leavesTaken.text = LeavesTableViewController.leavesTaken[indexPath.row]
        cell.lbl_reason.text = LeavesTableViewController.reason[indexPath.row]
        cell.lbl_please.text = LeavesTableViewController.comment[indexPath.row]
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickBtnAdd(_ sender: UIButton){
        self.performSegue(withIdentifier: "gotoAddLeave", sender: self)
    }

}
