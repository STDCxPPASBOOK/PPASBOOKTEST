//
//  PPASLocation.swift
//  PPASBOOK
//
//  Created by STDC_14 on 09/07/2024.
//

import Foundation

struct OperationHours {
    let open: String
    let close: String
    let breakStart: String?
    let breakEnd: String?
}

struct PPASLocation {
    let name: String
    let district: String
    let operationHours: [String: OperationHours]
}

import Foundation

func getCurrentStatus(for operationHours: OperationHours) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    let currentDate = Date()
    let calendar = Calendar.current
    let currentTime = formatter.string(from: currentDate)
    
    guard let openTime = formatter.date(from: operationHours.open),
          let closeTime = formatter.date(from: operationHours.close),
          let currentTimeDate = formatter.date(from: currentTime) else {
        return "Closed"
    }
    
    if currentTimeDate >= openTime && currentTimeDate <= closeTime {
        if let breakStart = operationHours.breakStart,
           let breakEnd = operationHours.breakEnd,
           let breakStartTime = formatter.date(from: breakStart),
           let breakEndTime = formatter.date(from: breakEnd) {
            
            if currentTimeDate >= breakStartTime && currentTimeDate <= breakEndTime {
                return "On Break"
            }
        }
        
        let soonToClose = calendar.date(byAdding: .minute, value: -30, to: closeTime)!
        if currentTimeDate >= soonToClose {
            return "Closing Soon"
        }
        
        return "Open"
    }
    
    return "Closed"
}

func getCurrentDayOperationStatus(for ppasLocation: PPASLocation) -> String {
    let date = Date()
    let calendar = Calendar.current
    let day = calendar.component(.weekday, from: date)
    let dayString = calendar.weekdaySymbols[day - 1]
    
    if let operationHours = ppasLocation.operationHours[dayString] {
        return getCurrentStatus(for: operationHours)
    }
    
    return "Closed"
}

func getCurrentDayOperationHours(for ppasLocation: PPASLocation) -> String {
    let date = Date()
    let calendar = Calendar.current
    let day = calendar.component(.weekday, from: date)
    let dayString = calendar.weekdaySymbols[day - 1]
    
    if let hours = ppasLocation.operationHours[dayString] {
        return "Open: \(hours.open) - Close: \(hours.close)"
    }
    
    return "Closed"
}
