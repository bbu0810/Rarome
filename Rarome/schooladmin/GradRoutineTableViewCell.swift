//
//  GradRoutineTableViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/2/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class GradRoutineTabelViewCell: UITableViewCell {
 
    class var expendedHeight: CGFloat{ get{return 2350}}
    class var defaultHeight: CGFloat{ get{return 50}}
    
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < ParentInfoTableCell.expendedHeight)
    }
    
    func watchFrameChanges(){
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        checkHeight()
    }
    
    func ignoreFrameChanges(){
        removeObserver(self, forKeyPath: "frame")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
}
