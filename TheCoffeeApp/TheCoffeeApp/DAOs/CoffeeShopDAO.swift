//
//  CoffeeShopDAO.swift
//  TheCoffeeApp
//
//  Created by Tiago Pereira on 17/04/2018.
//  Copyright © 2018 Apple Developer Academy. All rights reserved.
//

import Foundation

fileprivate var MINIMUN_NEARBY_DISTANCE = 300

class CoffeeShopDAO {
    
    private static var coffeeShops: [CoffeeShop] = [
        CoffeeShop(id: "001",
                   name: "University Bar",
                   location: Location(latitude: 0, longitude: 0),
                   imageURL: "coffee_shop_placeholder",
                   description: "That's a very good coffe bar nearby the Academy. Nunzia is a sweetheart.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("001")!, rating: 2, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("002")!, rating: 1, price: 1.9)
            ]),
        CoffeeShop(id: "002",
                   name: "Coffee Bar",
                   location: Location(latitude: 0, longitude: 0),
                   imageURL: "coffee_shop_placeholder",
                   description: "A random placeholder coffee bar to increase the amount of entries in the database.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("003")!, rating: 2, price: 1.5),
                    (coffee: CoffeeDAO.getCoffee("004")!, rating: 1, price: 0.9)
            ]),
        CoffeeShop(id: "003",
                   name: "Random Bar",
                   location: Location(latitude: 0, longitude: 0),
                   imageURL: "coffee_shop_placeholder",
                   description: "That's a random coffe bar added for testing purposes. Enjoy the randomness.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("005")!, rating: 2, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("006")!, rating: 1, price: 1.9)
            ]),
        CoffeeShop(id: "004",
                   name: "Another Bar",
                   location: Location(latitude: 0, longitude: 0),
                   imageURL: "coffee_shop_placeholder",
                   description: "That's a placeholder coffe bar added for testing purposes, again. Soon to be replaced with real information, hopefully.",
                   coffees: [
                    (coffee: CoffeeDAO.getCoffee("007")!, rating: 2, price: 0.9),
                    (coffee: CoffeeDAO.getCoffee("008")!, rating: 1, price: 1.9)
            ])
    ]
    
    static func getAll() -> [CoffeeShop] {
        return coffeeShops
    }
    
    // TODO: Split the dictionary in two keys
    static func getAll(splitedByMinimum distance: Double) -> [String: [CoffeeShop]] {
        return [
            "NEARBY" : [
                coffeeShops[0],
                coffeeShops[3]
            ],
            "OTHERS" : [
                coffeeShops[1],
                coffeeShops[2]
            ]
        ]
    }
    
}
