//
//  Languages.swift
//  Algorithms
//
//  Created by Florian Kasten on 9/5/17.
//  Copyright © 2017 Florian Kasten. All rights reserved.
//

import Foundation

enum Languages: Int {
    case swift
    case java
    case c
    case pseudo
    
    public static let mapper: [Languages: String] = [
        .swift: "Swift",
        .java: "Java",
        .c: "C",
        .pseudo: "Pseudocode"
    ]
    
    public var string: String {
        return Languages.mapper[self]!
    }
}
