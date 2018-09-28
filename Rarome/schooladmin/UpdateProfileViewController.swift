//
//  UpdateProfileViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/25/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit

class UpdateProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate{
    var sFirstName: String!
    var sLastName: String!
    var sEmail: String!
    var sImageUrl: String!
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var txt_first_name: UITextField!
    @IBOutlet weak var txt_last_name: UITextField!
    @IBOutlet weak var txt_email: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var imagePickerController : UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_first_name.text = sFirstName
        txt_first_name.delegate = self
        txt_last_name.text = sLastName
        txt_last_name.delegate = self
        txt_email.text = sEmail
        showImage()
        let singleTap = UITapGestureRecognizer(target: self, action: Selector("onClick_img"))
        img_profile.isUserInteractionEnabled = true
        img_profile.addGestureRecognizer(singleTap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:100), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    @IBAction func onClick_update(_ sender: UIButton, forEvent event: UIEvent) {
        let userid: String = sUserId
        let usertype: String = sUserType
        let schoolid: String = sSchoolID
        let runing_year: String = sRunging_year
        let firstname: String = txt_first_name.text!
        let lastname: String = txt_last_name.text!
        let email: String  = sEmail
        
        let url = URL(string: "https://demo.rarome.com/index.php/?api/update_profile")
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "school_id=\(schoolid)&running_year=\(runing_year)&user_type=\(usertype)&user_id=\(userid)&first_name=\(firstname)&last_name=\(lastname)&email=\(email )"
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
                    self.showResult(message: sMessage)
                }
                
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
        
    }
    
    func showImage(){
        let session = URLSession(configuration: .default)
        let url = URL(string: sImageUrl)!
        let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async{
                            self.img_profile.layer.borderWidth=1.0
                            self.img_profile.layer.masksToBounds = false
                            self.img_profile.layer.borderColor = UIColor.white.cgColor
                            self.img_profile.layer.cornerRadius = self.img_profile.frame.size.height/2
                            self.img_profile.clipsToBounds = true
                            self.img_profile.image = image
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
    
    func onClick_img(){
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        img_profile.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }

    func showResult(message: String){
        DispatchQueue.main.async(execute: {
            var alert = UIAlertController(title: "Result", message: message, preferredStyle: UIAlertControllerStyle.alert)
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
        })
    }
}
