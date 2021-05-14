//
//  DaumMapViewController.swift
//  SwiftStudy
//
//  Created by YooHG on 2021/04/05.
//  Copyright © 2021 Jell PD. All rights reserved.
//

import UIKit

class DaumMapViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MTMapView(frame: self.view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            self.view.addSubview(mapView)
            DispatchQueue.global().async {
                
                sleep(3)
                mapView.setMapCenter(MTMapPoint.init(geoCoord: MTMapPointGeo(latitude: 37.53737528, longitude: 127.00557633)), animated: true)
                sleep(3)
                let poiItem1 = MTMapPOIItem.init()
                poiItem1.itemName = "City on a Hill"
                poiItem1.mapPoint = MTMapPoint.init(geoCoord: MTMapPointGeo.init(latitude: 37.541889, longitude: 127.095388))
                poiItem1.markerType = .redPin
                poiItem1.showAnimationType = .dropFromHeaven
                poiItem1.draggable = true
                poiItem1.tag = 153
                mapView.add(poiItem1)
                mapView.fitAreaToShowAllPOIItems()
                
                let circle = MTMapCircle.init()
                circle.circleCenterPoint = MTMapPoint.init(geoCoord: MTMapPointGeo.init(latitude: 37.541889, longitude: 127.095388))
                circle.circleLineColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.5)
                circle.circleFillColor = UIColor.init(red: 0, green: 1, blue: 0, alpha: 0.5)
                circle.tag = 1234
                circle.circleRadius = 500
                mapView.addCircle(circle)
                mapView.fitArea(toShow: circle)
                mapView.setMapCenter(MTMapPoint.init(geoCoord: MTMapPointGeo.init(latitude: 37.541889, longitude: 127.095388)), animated: true)
//                let poiItem2 = MTMapPOIItem.init()
                
                
            }
        }
    }
}
