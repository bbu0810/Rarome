//
//  StudenDocumentsCell.swift
//  Rarome
//
//  Created by AntonDream on 8/1/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class StudenDocumentsCell: UITableViewCell {
 
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_size: UILabel!
    
    
    @IBAction func onClick_download(_ sender: UIButton, forEvent event: UIEvent) {
    }
    
    @IBAction func onClick_delete(_ sender: Any, forEvent event: UIEvent) {
    }
    
}
