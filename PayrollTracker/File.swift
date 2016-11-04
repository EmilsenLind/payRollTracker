//
//  File.swift
//  PayrollTracker
//
//  Created by Emil Møller Lind on 26/10/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import Foundation
extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
