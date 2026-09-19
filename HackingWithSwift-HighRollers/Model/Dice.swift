//
//  Dice.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 18/09/2026.
//

import Foundation
import SwiftData

@Model
class Dice {
    var id = UUID()
    var numberOfSides: Int
    var randomNumber: Int
    
    init(numberOfSides: Int) {
        self.numberOfSides = numberOfSides
        self.randomNumber = Int.random(in: 0..<numberOfSides)
    }
}
