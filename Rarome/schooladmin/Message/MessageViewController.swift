//
//  MessageViewController.swift
//  Rarome
//
//  Created by AntonDream on 8/20/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import DropDown
class MessageViewController: UIViewController {
//
//    @IBOutlet weak var view_toper: UIView!
//    @IBOutlet weak var view_top: UIView!
//    @IBOutlet weak var btn_selectRecipients: UIButton!
//    @IBOutlet weak var view_delectRecipientDrip: UIView!
    
    var sSelectRecipients = ["Teachers", "Employees", "Parents", "Students"]
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func buildUI(){
//        view_toper.layer.borderWidth = 1
//        view_toper.layer.cornerRadius = 5
//        view_toper.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
//        view_top.layer.borderWidth = 1
//        view_top.layer.cornerRadius = 5
//        view_top.layer.borderColor = UIColor(red: 93/255, green: 107/255, blue: 178/225, alpha: 1).cgColor
    }
//
//    @IBAction func onClickRecipient(_ sender: UIButton, forEvent event: UIEvent) {
//        let dropDown = DropDown()
//        dropDown.anchorView = view_delectRecipientDrip
//        dropDown.dataSource = self.sSelectRecipients
//        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//            self.btn_selectRecipients .setTitle(item, for: UIControlState.normal)
//        }
//        dropDown.width = view_delectRecipientDrip.frame.width
//        dropDown.show()
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
