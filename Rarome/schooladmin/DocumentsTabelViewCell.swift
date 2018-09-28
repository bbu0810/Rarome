//
//  DocumentsTabelViewCell.swift
//  Rarome
//
//  Created by AntonDream on 8/2/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import Foundation
import UIKit
class DocumentsTabelViewCell: UITableViewCell, UITableViewDataSource{
    @IBOutlet weak var tbl_documents: UITableView!
    
    var sDocumentTitles: [String]?
    var sDocumentDates: [String]?
    var sDocumentSizes: [String]?
    
    class var expendedHeight: CGFloat{ get{return 300}}
    class var defaultHeight: CGFloat{ get{return 50}}
    func checkHeight(){
        var bool: Bool
        bool = (frame.size.height < ParentInfoTableCell.expendedHeight)
        if bool == false {
            tbl_documents.dataSource = self
            tbl_documents.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gotoDetailDocumentsTableViewCell") as! DetailDocumentsTableViewCell
        cell.lbl_documentTitle.text = sDocumentTitles?[indexPath.row]
        cell.lbl_documentDate.text = sDocumentDates?[indexPath.row]
        cell.lbl_documenttSize.text = sDocumentSizes?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sDocumentTitles!.count
    }
}
