//
//  DetailProgressHistoryViewController.swift
//  Rarome
//
//  Created by AntonDream on 9/5/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import StarReview
class DetailProgressHistoryViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var tbl_history: UITableView!
    
    var starReviews = [String]()
    var dates = [String]()
    var comments = [String]()
    
    var star = StarReview()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudentProgressHistory()
        tbl_history.dataSource = self
    }

    @IBAction func onClick_back(_ sender: UIButton, forEvent event: UIEvent) {
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starReviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoProgressHistoryTableViewCell") as? DetailHistoryTableViewCell
        cell?.lbl_comment.text = self.comments[indexPath.row]
        cell?.lbl_date.text = self.dates[indexPath.row]
        var rate = (self.starReviews[indexPath.row] as NSString).floatValue
        star = makeStarRate(rate: rate)
        cell?.view_starReview.addSubview(star)
        return cell!
    }
    
    func getStudentProgressHistory(){
        let school_id = GlobalConst.glb_sSchoolID!
        let running_year = GlobalConst.glb_sRunning_year!
        let user_type = GlobalConst.glb_sUserType!
        let user_id = GlobalConst.glb_sUserId!
        let student_id = GlobalConst.glb_studentID ?? ""
        let subject_id = GlobalConst.glb_subjectID ?? ""
        
        self.starReviews.removeAll()
        self.comments.removeAll()
        self.dates.removeAll()
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_history_progress_report")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(school_id)&running_year=\(running_year)&user_type=\(user_type)&user_id=\(user_id)&student_id=\(student_id)&subject_id=\(subject_id)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                let iStatus = parseData["status"] as! Int
                let sMessage = parseData["message"] as! String
                if iStatus == 1 {
                    let historis = parseData["progress_report_history"] as! [[String:Any]]
                    for history in historis {
                        let comment = history["comment"] as! String
                        self.comments.append(comment)
                        let rate = history["rate"] as! String
                        self.starReviews.append(rate)
                        let date = history["timestamp"] as! String
                        self.dates.append(date)
                    }
                    DispatchQueue.main.async(execute: {
                        self.tbl_history.dataSource = self
                        self.tbl_history.reloadData()
                    })
                }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func makeStarRate(rate: Float) -> StarReview {
        var star = StarReview()
        star.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        star.starMarginScale = 0.3
        star.value = rate
        star.starCount = 5
        star.allowEdit = false
        star.allowAccruteStars = true
        star.starBackgroundColor = UIColor.lightGray
        if rate < 2 {
            star.starFillColor = UIColor.red
        } else if  rate < 3 {
            star.starFillColor = UIColor.orange
        } else if rate < 4 {
            star.starFillColor = UIColor.blue
        } else if rate < 5 {
            star.starFillColor = UIColor.yellow
        } else {
            star.starFillColor = UIColor.green
        }
        return star
    }
}
