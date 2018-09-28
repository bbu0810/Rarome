//
//  ProfileViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/24/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var img_profile_photo: UIImageView!
    @IBOutlet weak var txt_name: UILabel!
    @IBOutlet weak var txt_Email: UILabel!

    var sEmail: String!
    var sName: String!
    var sImagePath: String!
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    
    var sProfilePhotoUrl: String!
    var sFirstName: String!
    var sLastName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestinationViewController = segue.destination as! UpdateProfileViewController
        DestinationViewController.sFirstName = sFirstName
        DestinationViewController.sLastName = sLastName
        DestinationViewController.sEmail = sEmail
        DestinationViewController.sImageUrl = sProfilePhotoUrl
        DestinationViewController.sUserType = sUserType
        DestinationViewController.sUserId = sUserId
        DestinationViewController.sSchoolID = sSchoolID
        DestinationViewController.sRunging_year = sRunging_year
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showProfilePhoto()
        appComponentsInNavigationBar()
        txt_name.text = sName
        txt_Email.text = sEmail
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showProfilePhoto(){
        if self.sImagePath == nil {
            return
        }
        let userid: String = sUserId
        let usertype: String = sUserType
        let schoolid: String = sSchoolID
        let runing_year: String = sRunging_year
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_profile")
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)"
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
                if iStatus == 1 {
                   let recode = try parseData["record"] as! [String:Any]
                    self.sProfilePhotoUrl = recode["profile_pic"] as! String
                    self.sFirstName = recode["first_name"] as! String
                    self.sLastName = recode["last_name"] as! String
                    self.showPhoto()
                }

            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }
    
    func showString(message: String){
        var alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                return
            case .cancel:
                print("cancel")
                return
            case .destructive:
                print("destructive")
                return
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showPhoto(){
        let session = URLSession(configuration: .default)
        let url = URL(string: sProfilePhotoUrl)!
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async{
                            self.img_profile_photo.layer.borderWidth=1.0
                            self.img_profile_photo.layer.masksToBounds = false
                            self.img_profile_photo.layer.borderColor = UIColor.white.cgColor
                            self.img_profile_photo.layer.cornerRadius = self.img_profile_photo.frame.size.height/2
                            self.img_profile_photo.clipsToBounds = true
                            self.img_profile_photo.image = image
                            var first: String = self.sFirstName
                            var last: String = self.sLastName
                            self.txt_name.text = "\(first) \(last)"
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        downloadPicTask.resume()
    }
    
    func appComponentsInNavigationBar(){
        if let navigationBar = self.navigationController?.navigationBar{
            let btn_edit = UIButton(type: UIButtonType.custom)
            btn_edit.setImage(UIImage(named: "ic_edit"), for: UIControlState.normal)
            btn_edit.addTarget(self, action: #selector(ProfileViewController.gotoEditProfileViewController), for: UIControlEvents.touchDown)
            btn_edit.frame=CGRect(x: 30, y: 0, width: 30,  height: navigationBar.frame.height)
            let barEdit = UIBarButtonItem(customView: btn_edit)
            self.navigationItem.rightBarButtonItems = [barEdit]
        }
    }
    
    func gotoEditProfileViewController(){
//        self.performSegue(withIdentifier: "gotoEditProfileViewConroller", sender: self)
        self.performSegue(withIdentifier: "gotoUploadProfileViewConroller", sender: self)
    }
}
