//
//  Double+Ex.swift
//  CircleOfMoneyProgrammaticaly
//
//  Created by Hellizar on 28.02.21.
//

import Foundation

extension Double {
    func roundUpTwoCharacters(_ number: Double) -> Double {
        return Double((100 * number).rounded() / 100)
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
