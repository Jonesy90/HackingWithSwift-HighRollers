//
//  DiceResult.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 23/09/2026.
//

import Foundation
import SwiftData

/// @Model is a SwiftData annotation that tells us the class of 'DiceResult' prepresents a persistable data model. This means the instance of DiceResult can be saved and fetched from a SwiftData-backed database.
@Model
class DiceResult {
    var id = UUID()
    var type: Int /// Represents the type of dice (e.g., 6 for a 6-sided die).
    var number: Int /// Represents the number of dice rolled.
    var rolls = [Int]() /// A Int array to represent the result of each die roll.
    
    /// A computed property to converted the contents of rolls into a comma-seperated string (e.g., "5, 4, 3, 2").
    var description: String {
        rolls.map(String.init).joined(separator: ", ")
    }
    
    /// When a new DiceResult is created, the type and number will be provided. The initialiser will then roll the dice by picking a random number between 1 and the type, then appends it to the rolls array.
    init(type: Int, number: Int) {
        self.type = type
        self.number = number
        
        for _ in 0..<number {
            let roll = Int.random(in: 1...type)
            rolls.append(roll)
        }
    }
}
