//
//  payRoll.swift
//  PayrollTracker
//
//  Created by Emil Møller Lind on 24/10/2016.
//  Copyright © 2016 Emil Møller Lind. All rights reserved.
//

import Foundation

class payRoll {
    
    private var _hoursWorked: Double!
    private var _payPerHour: Double!
    private var _canCalculate: Bool = true
    
    
    public var hoursWorked: Double {
        if _hoursWorked == nil {
            _hoursWorked = 0.0
        }
        return _hoursWorked
    }
    
    init(from: Date, to: Date, payPerHour: String?) {
        let result = calculateWorkedHours(from: from, to: to)
        self._hoursWorked = result
        self._payPerHour = Double(payPerHour!)
        }
    
    //Functions
    
    func calculate() -> (Double, Double) {
        
       let result1 = self._hoursWorked * self._payPerHour
        let result2 = result1 - (result1 * 0.48)
        
        return (result1.roundTo(places: 1), result2.roundTo(places: 1))
        
    }
    
    
    func calculateWorkedHours(from: Date, to: Date) -> Double {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd, MMMM yyyy HH:mm:ss"
        let calendar = Calendar(identifier: .gregorian)
        var fromComponents = calendar.dateComponents([.year, .day, .month, .hour, .minute, .second], from: from)
        var toComponents = calendar.dateComponents([.day,.month, .year, .hour, .minute, .second], from: to)
        
        fromComponents.second = 0
        toComponents.second = 0
        
        
        let realFrom = calendar.date(from: fromComponents)
        let realTo = calendar.date(from: toComponents)
        let diffDateComponents = calendar.dateComponents([.hour, .minute], from: realFrom!, to: realTo!)
        let hour = Double(diffDateComponents.hour!)
        let minute = (Double(diffDateComponents.minute!)) / 60
        var result = hour + minute
        return result.roundTo(places: 1)
    }
    
    
}
