//
//  NumberOrder.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/3/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

enum NumberOrder: Int, CaseIterable {
    case random
    case sortedUp
    case sortedDown

    public static let mapper: [NumberOrder: String] = [
        .random: "random",
        .sortedUp: "sorted (<)",
        .sortedDown: "sorted (>)"
    ]

    public var string: String {
        return NumberOrder.mapper[self]!
    }
}
