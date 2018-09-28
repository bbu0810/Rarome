//
//  StudentTableViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/30/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

let cellID = "cellStudentInfomation"

class StudentTableViewController: UITableViewController {
    
    var refreshCtrl: UIRefreshControl!
    var tableData:[AnyObject]!
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    var selectedIndexPath: IndexPath?
    
    var studentsNames: [String]?
    var studentIDs: [String]?
    var fatherNames: [String]?
    var motherNames: [String]?
    var gentherName: [String]?
    var emergency: [String]?
    var studentImgURL: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.studentsNames?.count)!
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellStudentInfomation", for: indexPath) as! StudentInfoTableCell
        let index = indexPath.row
        cell.lbl_userName.text = self.studentsNames?[index]
        cell.lbl_fatherName.text = self.fatherNames?[index]
        cell.lbl_motherName.text = self.motherNames?[index]
        cell.lbl_gender.text = self.gentherName?[index]
        cell.lbl_emergency.text = self.emergency?[index]
        cell.studentid = self.studentIDs?[index]
        cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
        
        if (self.studentImgURL?[index].count)! > 4 {
            let photourl = GlobalConst.glb_studentImg_path + self.studentImgURL![index]
            let session = URLSession(configuration: .default)
            let url = URL(string: photourl)!
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    DispatchQueue.main.async{
                        cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                    }
                } else {
                    if let res = response as? HTTPURLResponse {
                        print("Downloaded cat picture with response code \(res.statusCode)")
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            if ((image?.size) != nil){
                                DispatchQueue.main.async{
                                    if let updateCell = tableView.cellForRow(at: indexPath){
                                        let cell = updateCell as! StudentInfoTableCell
                                        cell.imgView_userPhoto?.image = image
                                        cell.imgView_userPhoto.layer.borderWidth=1.0
                                        cell.imgView_userPhoto.layer.masksToBounds = false
                                        cell.imgView_userPhoto.layer.borderColor = UIColor.white.cgColor
                                        cell.imgView_userPhoto.layer.cornerRadius = cell.imgView_userPhoto.frame.size.height/2
                                        cell.imgView_userPhoto.clipsToBounds = true
                                    }
                                }
                            } else {
                                DispatchQueue.main.async{
                                    cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                                }
                            }
                        } else {
                            DispatchQueue.main.async{
                                cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                            }
                        }
                    } else {
                        DispatchQueue.main.async{
                            cell.imgView_userPhoto.image = UIImage(named: "ic_userPhoto")
                        }
                    }
                }
            }
            downloadPicTask.resume()
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath{
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        tableView.reloadData()
        var indexPaths: Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths as [IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! StudentInfoTableCell).watchFrameChanges()
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! StudentInfoTableCell).ignoreFrameChanges()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return StudentInfoTableCell.expendedHeight
        } else {
            return StudentInfoTableCell.defaultHeight
        }
    }
    
//    func refreshTableView(){
//        let url:URL! = URL(string: "https://itunes.apple.com/search?term=flappy&entity=software")
//        task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
//
//            if location != nil{
//                let data:Data! = try? Data(contentsOf: location!)
//                do{
//                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
//                    self.tableData = dic.value(forKey : "results") as? [AnyObject]
//                    DispatchQueue.main.async(execute: { () -> Void in
//                        self.tableView.reloadData()
//                        self.refreshControl?.endRefreshing()
//                    })
//                }catch{
//                    print("something went wrong, try again")
//                }
//            }
//        })
//        task.resume()
//    }

}
