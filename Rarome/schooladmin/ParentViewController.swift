//
//  ParentViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/26/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentViewController: ButtonBarPagerTabStripViewController{
    
    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    
    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
        super.viewDidLoad()
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let grad = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let term = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        let student = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child3")
        var Destination_Grad: Grade_WiseViewController = grad as! Grade_WiseViewController
        Destination_Grad.sUserId = self.sUserId
        Destination_Grad.sUserType = self.sUserType
        Destination_Grad.sSchoolID = self.sSchoolID
        Destination_Grad.sRunging_year = self.sRunging_year
        return [grad, term, student]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
