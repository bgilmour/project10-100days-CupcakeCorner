//
//  Order.swift
//  CupcakeCorner
//
//  Created by Bruce Gilmour on 2021-07-21.
//

import SwiftUI

class Order: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    @Published var details = OrderDetails()

    var hasValidAddress: Bool {
        if details.name.trimmingCharacters(in: .whitespaces).isEmpty || details.streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || details.city.trimmingCharacters(in: .whitespaces).isEmpty || details.zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        return true
    }

    var cost: Double {
        // base cost is $2 per cake
        var cost = Double(details.quantity) * 2

        // add on a premium for more comples cake types
        cost += Double(details.type) / 2

        // add $1/cake for extra frosting
        if details.extraFrosting {
            cost += Double(details.quantity)
        }

        // add 50c/cake for sprinkles
        if details.addSprinkles {
            cost += Double(details.quantity)  / 2
        }

        return cost
    }

}

struct OrderDetails: Codable {
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}
