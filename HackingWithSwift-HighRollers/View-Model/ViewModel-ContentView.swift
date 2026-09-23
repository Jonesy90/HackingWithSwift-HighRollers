//
//  ViewModel-ContentView.swift
//  HackingWithSwift-HighRollers
//
//  Created by Michael Jones on 23/09/2026.
//

import Combine
import SwiftUI
import SwiftData

extension ContentView {
    /// The class is designed to manage the logic and state for the app.
    @Observable
    class ViewModel {
        let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        /// An array of integers to represent the types of dice that can be rolled.
        let diceTypes = [4, 6, 8, 10, 12, 20, 100]

        /// A SwiftUI layout property. To be used for displaying dice in a grid with a minimum size of 60 points.
        let columns: [GridItem] = [
            .init(.adaptive(minimum: 60))
        ]
        
        /// An integer to hold the device types.
        var selectedDiceTypes = 6
        /// An integer to hold the amount of dice.
        var numberOfRoll = 4
        ///
        var stoppedDice = 0
        
        /// Stores the result for the most recent dice roll.
        var currentResult = DiceResult(type: 0, number: 0)
        
        
        /// If voice over is enabled it sets stoppedDice to the total number of dice, which will be disable the animation. Otherwise, it will set it to -20. Then initialises 'currentResult' as a new 'DiceResult' with the current selectedDiceType and numberOfRoll.
        /// - Parameter voiceOverEnabled: Environment property called 'accessibilityVoiceOverEnabled'.
        func rollDice(voiceOverEnabled: Bool) {
            if voiceOverEnabled {
                stoppedDice = numberOfRoll
            } else {
                stoppedDice = -20
            }
            
            currentResult = DiceResult(type: selectedDiceTypes, number: numberOfRoll)
        }
        
        /// This is meant to give the animation look of the numbers changing until they fall onto the numbers they were assigned.
        /// - Parameter modelContext: Environment modelContext for SwiftData.
        func updateDice(modelContext: ModelContext) {
            /// Only updates if stoppedDice is less than the number of rolls in currentResult.
            guard stoppedDice < currentResult.rolls.count else { return }
            
            /// Loops over stoppedDice and ignoring any minus numbers.
            /// Setting each die to a random number between 1 and the selectedDiceType.
            for i in stoppedDice..<numberOfRoll {
                if i < 0 { continue }
                currentResult.rolls[i] = Int.random(in: 1...selectedDiceTypes)
            }
            
            /// Increments stoppedDice by 1.
            stoppedDice += 1
            
            /// Once stoppedDice is equal to numberOfRoll, it will insert the results to SwiftData using model context.
            if stoppedDice == numberOfRoll {
                modelContext.insert(currentResult)
            }
        }
    }
}
