

import UIKit

class EditProfileViewController: UIViewController {

    var sFirstName: String!
    var sLastName: String!
    var sEmail: String!
    var sImageUrl: String!
    
    @IBOutlet weak var img_profile: UIImageView!
    @IBOutlet weak var txt_first_name: UITextField!
    @IBOutlet weak var txt_last_name: UITextField!
    @IBOutlet weak var txt_email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_first_name.text = sFirstName
        txt_last_name.text = sLastName
        txt_email.text = sEmail
        showImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onClick_update(_ sender: Any, forEvent event: UIEvent) {
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
                            self.img_profile.layer.cornerRadius = self.img_profile
                                .frame.size.height/2
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
}
