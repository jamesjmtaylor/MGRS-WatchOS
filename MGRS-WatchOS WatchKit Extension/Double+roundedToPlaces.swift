//
//  Double+roundedToPlaces.swift
//  MGRS-WatchOS WatchKit Extension
//
//  Created by James Taylor on 3/15/20.
//  Copyright © 2020 James Taylor. All rights reserved.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
