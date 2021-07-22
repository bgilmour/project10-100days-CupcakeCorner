This is my solution to the CupcakeCorner project (project 10) in the [100 Days Of SwiftUI](https://www.hackingwithswift.com/100/swiftui/) tutorial created by Paul Hudson ([@twostraws](https://github.com/twostraws)).

Challenge 1 adds some additional address field validation to trim whitespace before checking for a non-empty entry.

Challenge 2 adds alerts for network errors that may occur.

Challenge 3 restructured the data model so that Order no longer had to conform to Codable. Instead, the single published property is now a struct called OrderDetails which conforms to Codable with no additional coding i.e. the CodingKey enum, the required init, and the encode function have all been removed from the Order class and nothing has been added to the OrderDetails struct.
