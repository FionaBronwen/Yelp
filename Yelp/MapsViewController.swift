//
//  MapsViewController.swift
//  Yelp
//
//  Created by Fiona Thompson on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var businesses: [Business]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        goToLocation(location: centerLocation)
        
        if let businesses = self.businesses{
            for business in businesses {
                addAnnotationAtAddress(address: business.address!, title: business.name!)

            }
            //print("Business Name: \(business.name) Business Address: \(business.address)")
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }

    func addAnnotationAtAddress(address: String, title: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
