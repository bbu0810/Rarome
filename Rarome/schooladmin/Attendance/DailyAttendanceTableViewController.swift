//
//  DailyAttendanceTableViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/20/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class DailyAttendanceTableViewController: UITableViewController {
    var names = [String]()
    var img_urls = [String]()
    var in_times = [String]()
    var out_times = [String]()
    var status = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDailyAttendanceTableViewCell", for: indexPath) as! DailyAttendanceTableViewCell
        cell.lbl_name.text = names[indexPath.row]
        let inTime = self.in_times[indexPath.row]
        let in_time = "Time in: \(inTime)"
        cell.lbl_in_time.text = in_time
        let outTime = self.out_times[indexPath.row]
        let out_time = "Time out: \(outTime)"
        cell.lbl_out_time.text = out_time
        if status[indexPath.row] == nil{
            cell.lbl_statu.text = "Undefine"
        }else{
            cell.lbl_statu.text = self.status[indexPath.row]
        }
        
        if self.img_urls[indexPath.row].count > 11 {
            let photourl = GlobalConst.glb_studentImg_path + self.img_urls[indexPath.row]
            let session = URLSession(configuration: .default)
            let url = URL(string: photourl)!
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    DispatchQueue.main.async{
                        cell.img_uerPhoto.image = UIImage(named: "ic_userPhoto")
                    }
                } else {
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded cat picture with response code \(res.statusCode)")
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            if ((image?.size) != nil){
                                DispatchQueue.main.async{
                                    if let updateCell = tableView.cellForRow(at: indexPath){
                                        let cell = updateCell as! DailyAttendanceTableViewCell
                                        cell.img_uerPhoto?.image = image
                                        cell.img_uerPhoto.layer.borderWidth=1.0
                                        cell.img_uerPhoto.layer.masksToBounds = false
                                        cell.img_uerPhoto.layer.borderColor = UIColor.white.cgColor
                                        cell.img_uerPhoto.layer.cornerRadius = cell.img_uerPhoto.frame.size.height/2
                                        cell.img_uerPhoto.clipsToBounds = true
                                        
                                    } else {
                                        DispatchQueue.main.async{
                                            cell.img_uerPhoto.image = UIImage(named: "ic_userPhoto")
                                        }
                                    }
                                }
                            } else {
                                DispatchQueue.main.async{
                                    cell.img_uerPhoto.image = UIImage(named: "ic_userPhoto")
                                }
                            }
                        } else {
                            DispatchQueue.main.async{
                                cell.img_uerPhoto.image = UIImage(named: "ic_userPhoto")
                            }
                        }
                    } else {
                        DispatchQueue.main.async{
                            cell.img_uerPhoto.image = UIImage(named: "ic_userPhoto")
                        }
                    }
                }
            }
            downloadPicTask.resume()
        }
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

}
