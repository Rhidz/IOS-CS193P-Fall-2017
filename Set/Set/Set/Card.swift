//
//  Deck.swift
//  Set
//
//  Created by Ishrat Rhidita on 23/3/19.
//  Copyright © 2019 Ishrat Rhidita. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var isSelected = false
    var isMatched = false
    var contentsOf = false
    var identifier: Int
    
    static var indentifierFactory = 0
    
    static func getIdentifier() -> Int {
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init() {
        self.identifier = Card.getIdentifier()
    }
}