//
//  GoogleMapViewController.swift
//  Rarome
//
//  Created by AntonDream on 7/23/18.
//  Copyright © 2018 AntonDream. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {
    var mapView: GMSMapView!

    var sUserId: String!
    var sUserType: String!
    var sSchoolID: String!
    var sRunging_year: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInfoFromServer()
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        showBus1(position: camera.target)
        showBus2(position: position)
    }
    
    func showBus1(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Bus"
        marker.icon = UIImage(named: "ic_bus")
        marker.map = mapView

    }
    func showBus2(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
        marker.title = "Bus"
        marker.icon = UIImage(named: "ic_bus")
        marker.map = mapView
    }
    
    func getInfoFromServer(){
        let url = URL(string: "https://demo.rarome.com/index.php/?api/get_mobile_gps_location")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var sDeviceToken: String = ""
        var iDeviceID: String = (UIDevice.current.identifierForVendor?.uuidString)!
        let postString = "user_id=\(sUserId)&user_type=\(sUserType)&school_id=\(sSchoolID)&running_year=\(sRunging_year)"
        request.httpBody = postString.data(using: .utf8);
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            do{
                let parseData = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            } catch let error as NSError {
                print(error)
            }
            print("responseString = \(responseString)")
        }
        task.resume()
        
    }



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
