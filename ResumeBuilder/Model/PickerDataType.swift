//
//  PickerDataType.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import Foundation

enum PickerDataType: Equatable {
    case yearsExperience
    case month(RangeType)
    case year(RangeType)
    case educationStatus
    
    enum RangeType: String {
        case starting, ending
    }
    
    var rowTitles: [String] {
        switch self {
        case .yearsExperience: return (0...30).map { String($0) }
        case .month: return Calendar.current.monthSymbols
        case .year: return (1980...2022).reversed().map { String($0) }
        case .educationStatus: return ["Graduated", "Dropped Out", "Entered"]
        }
    }
    
}
