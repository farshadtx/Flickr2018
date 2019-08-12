//
//  Calendar.swift
//  Flicker Best18
//
//  Created by Farshad Sheykhi on 8/11/19.
//  Copyright © 2019 Farshad. All rights reserved.
//

enum Calendar { }

extension Calendar {
    struct Month {
        let name: String
        let days: Int
    }

    static var months: [Month] {
        return [
            Month(name: "January", days: 31),
            Month(name: "February", days: 28),
            Month(name: "March", days: 31),
            Month(name: "April", days: 30),
            Month(name: "May", days: 31),
            Month(name: "June", days: 30),
            Month(name: "July", days: 31),
            Month(name: "August", days: 31),
            Month(name: "September", days: 30),
            Month(name: "October", days: 31),
            Month(name: "November", days: 30),
            Month(name: "December", days: 31)
        ]
    }
}
