//
//  NearbyCoffeShopsTableViewController.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import UIKit

// TODO: Explain
fileprivate let NEARBY: String = "NEARBY"
fileprivate let OTHERS: String = "OTHERS"

class NearbyCoffeShopsTableViewController: UITableViewController {

    // TODO: Explain
    var coffeeShops: [String: [CoffeeShop]] = [
        NEARBY: [],
        OTHERS: []
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Get the information from the DAO to populate the local array
        self.coffeeShops = CoffeeShopDAO.getAll(splitedByMinimum: 100)
        print("[LOG] Coffee bars around: \(self.coffeeShops)")
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // 2. Sets up all the proximity notifications
        CoffeeShopDAO.setUpLocationNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    // TODO: Explain
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.coffeeShops.count
    }

    // TODO: Explain
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowsArray: [CoffeeShop]
        
        switch section {
        case 0:
            rowsArray = self.coffeeShops[NEARBY] ?? []
            // Empty State
            if rowsArray.count == 0 { return 1 }
        case 1:
            rowsArray = self.coffeeShops[OTHERS] ?? []
        default:
            rowsArray = []
        }

        return rowsArray.count
    }

    // TODO: Explain
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 && self.coffeeShops[NEARBY]!.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyStateCell", for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeShopIdentifier", for: indexPath)
        
        let coffeeShopForCell = self.coffeeShop(for: indexPath)
        
        if let coffeeShopCell = cell as? NearbyCoffeeShopTableViewCell,
           let coffeeShop = coffeeShopForCell {
            
            coffeeShopCell.nameLabel.text = coffeeShop.name
            coffeeShopCell.topCoffeLabel.text = "☆ Coffee \(coffeeShop.topThreeCoffees[0].name)"
            
            let distanceText = String(format: "%.2fkm from you", coffeeShop.distanceFromYou)
            
            coffeeShopCell.distanceLabel.text = distanceText
            
            // TODO: Prepare to download the image
            coffeeShopCell.coffeeShopImageView.image = UIImage(named: coffeeShop.imageURL)
        }
        
        return cell
    }
    
    // TODO: Explain
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Other coffee shops"
        default:
            return nil
        }
    }

    // MARK: - Navigation
    
    // TODO: Explain
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "coffeeShopDetailIdentifier" {
            if let coffeeBarDetailVC = segue.destination as? CoffeBarDetailTableViewController {
                if let selectedIndex = tableView.indexPathForSelectedRow {
                    let sectionKey = (selectedIndex.section == 0) ? NEARBY : OTHERS
                    let selectedCoffeBar = self.coffeeShops[sectionKey]![selectedIndex.row]
                    
                    coffeeBarDetailVC.coffeeBar = selectedCoffeBar
                }
            }
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        print("[LOG] Back from coffee bar details.")
    }

    func coffeeShop(for indexPath: IndexPath) -> CoffeeShop? {
        let coffeeShop: CoffeeShop
        let coffeeShops: [CoffeeShop]
        
        if indexPath.section == 0 {
            coffeeShops = self.coffeeShops[NEARBY] ?? []
        } else {
            coffeeShops = self.coffeeShops[OTHERS] ?? []
        }
        
        coffeeShop = coffeeShops[indexPath.row]
        
        return coffeeShop
    }
}
