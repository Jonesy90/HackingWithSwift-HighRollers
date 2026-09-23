//
//  Dice.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 18/09/2026.
//

import Foundation
import SwiftData

@Model
class Dice: Identifiable {
    var id = UUID()
    var sessionID: UUID
    var timeStamp = Date.now
    var numberOfSides: Int
    var randomNumber: Int
    
    init(numberOfSides: Int, sessionID: UUID) {
        self.numberOfSides = numberOfSides
        self.randomNumber = Int.random(in: 1..<numberOfSides + 1)
        self.sessionID = sessionID
    }
    
    convenience init(numberOfSides: Int) {
        self.init(numberOfSides: numberOfSides, sessionID: UUID())
    }
}
