import Foundation
import UIKit
class ParentInfoTableCell: UITableViewCell{
    @IBOutlet weak var lbl_fatherName: UILabel!
    @IBOutlet weak var lbl_fatherPhone: UILabel!
    @IBOutlet weak var lbl_fatherEmail: UILabel!
    @IBOutlet weak var lbl_motherName: UILabel!
    @IBOutlet weak var lbl_motherPhone: UILabel!
    @IBOutlet weak var lbl_motherEmail: UILabel!
    
    class var expendedHeight: CGFloat{ get{return 250}}
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
