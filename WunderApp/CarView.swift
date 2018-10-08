//
//  CarView.swift
//  WunderApp
//
//  Created by Hao Wu on 2018/10/5.
//  Copyright © 2018年 Hao Wu. All rights reserved.
//

import Foundation
import MapKit

class CarView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let car = newValue as? Car else {return}
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
            mapsButton.setBackgroundImage(UIImage(named: "Maps-icon"), for: UIControl.State())
            rightCalloutAccessoryView = mapsButton
            
            // test
            isHidden = false

            
            if let imageName = car.imageName {
                image = UIImage(named: imageName)
            } else {
                image = nil
            }
        }
    }
}
