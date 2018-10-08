//
//  TableViewCell.swift
//  WunderApp
//
//  Created by Hao Wu on 2018/10/4.
//  Copyright © 2018年 Hao Wu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var engineType: UILabel!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var fuel: UILabel!
    @IBOutlet weak var interior: UILabel!
    @IBOutlet weak var exterior: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!    
    @IBOutlet weak var interiorLabel: UILabel!
    @IBOutlet weak var vinLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var exteriorLabel: UILabel!
    @IBOutlet weak var engineTypeLabel: UILabel!

    func setCar(car: Car) {
        name.text = car.name
        address.text = car.address
        engineType.text = car.engineType
        vin.text = car.vin
        fuel.text = car.fuel
        interior.text = car.interior
        exterior.text = car.exterior
        
        nameLabel.text = car.nameLabel
        addressLabel.text = car.addressLabel
        interiorLabel.text = car.interiorLabel
        vinLabel.text = car.vinLabel
        fuelLabel.text = String(car.fuelLabel)
        exteriorLabel.text = car.exteriorLabel
        engineTypeLabel.text = car.engineTypeLabel
    }


}














