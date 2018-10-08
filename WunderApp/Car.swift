//
//  car.swift
//  WunderApp
//
//  Created by Hao Wu on 2018/10/4.
//  Copyright © 2018年 Hao Wu. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Car: NSObject, MKAnnotation {
    let name: String = "Name:"
    let address: String = "Address:"
    let engineType: String = "Engine Type:"
    let vin: String = "Vin:"
    let fuel: String = "Fuel:"
    let interior: String = "Interior:"
    let exterior: String = "Exterior:"
    
    let nameLabel: String
    let addressLabel: String
    let interiorLabel: String
    let vinLabel: String
    let fuelLabel: Int
    let exteriorLabel: String
    let engineTypeLabel: String
    
    var title: String? {
        return nameLabel
    }
    var subtitle: String? {
        return addressLabel
    }
    
    let coordinate: CLLocationCoordinate2D
    let imageName: String? = "Car"
    
    init(nameLabel: String, addressLabel: String, interiorLabel: String, vinLabel: String, fuelLabel: Int, exteriorLabel: String, engineTypeLabel: String, coordinate: CLLocationCoordinate2D) {
        self.nameLabel = nameLabel
        self.addressLabel = addressLabel
        self.interiorLabel = interiorLabel
        self.vinLabel = vinLabel
        self.fuelLabel = fuelLabel
        self.exteriorLabel = exteriorLabel
        self.engineTypeLabel = engineTypeLabel
        self.coordinate = coordinate
        
        super.init()
    }
    
    init?(json: [String: Any]) {
        
        self.nameLabel = json["name"] as! String
        self.addressLabel = json["address"] as! String
        self.interiorLabel = json["interior"] as! String
        self.vinLabel = json["vin"] as! String
        self.fuelLabel = json["fuel"] as! Int
        self.exteriorLabel = json["exterior"] as! String
        self.engineTypeLabel = json["engineType"] as! String
        
        if let coordinates = json["coordinates"] as? [Double] {
            self.coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
        } else {
            self.coordinate = CLLocationCoordinate2D()
        }
        
    }
    
    // Annotation right callout accessory opens this mapItem in Maps app
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }

    
}




























