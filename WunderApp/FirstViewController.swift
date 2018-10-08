//
//  FirstViewController.swift
//  WunderApp
//
//  Created by Hao Wu on 2018/10/3.
//  Copyright © 2018年 Hao Wu. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    var cars: [Car] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadInitialData()
    }
    
    func loadInitialData() {
        guard let fileName = Bundle.main.path(forResource: "locations", ofType: "json")
            else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String: Any],
            let works = dictionary["placemarks"] as? [[String: Any]]
            else { return }
        
        let validWorks = works.compactMap { Car(json: $0) }
        
        cars = validWorks
    }

    
}


extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let car = cars[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.setCar(car: car)
        return cell
    }
    
}














