//
//  CareerViewModel.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/12/22.
//

import UIKit

// View Data for PositionTableViewCell
struct WorkPosition: Equatable {
    var startingMonth: String?
    var startingYear: String?
    var endingMonth: String?
    var endingYear: String?
    var title: String?
}

enum PickerDataType: Equatable {
    case yearsExperience
    case month(RangeType)
    case year(RangeType)
    
    enum RangeType: String {
        case starting, ending
    }
    
    var rowTitles: [String] {
        switch self {
        case .yearsExperience: return (0...30).map { String($0) }
        case .month: return Calendar.current.monthSymbols
        case .year: return (1980...2022).reversed().map { String($0) }
        }
    }
    
}

class CareerViewModel {
    // MARK: UI Constants
    let positionRowHeight: CGFloat = 160
    var positionsTableViewHeight: CGFloat {
        positionRowHeight * CGFloat(positions.count)
    }
    
    // MARK: Data
    var objective: String?
    var selectedYearsExperience: Int?
    var positions: [WorkPosition] = []

    // MARK: State
    var pickerDataType: PickerDataType = .yearsExperience
    var currentPositionIndex: Int?
    
    // MARK: Methods
    func onYearsExperienceTap() {
        pickerDataType = .yearsExperience
    }
    
    func onPositionTimeTap(at indexPath: IndexPath, pickerDataType pickerType: PickerDataType) {
        currentPositionIndex = indexPath.row
        pickerDataType = pickerType
    }
    
    func onSelectPicker(row: Int) {
        switch pickerDataType {
        case .yearsExperience:
            selectedYearsExperience = row
        case .month(let rangeType):
            guard row < pickerDataType.rowTitles.count, let currentPositionIndex = currentPositionIndex, currentPositionIndex < positions.count else { return }
            let title = pickerDataType.rowTitles[row]
            switch rangeType {
            case .starting:
                positions[currentPositionIndex].startingMonth = title
            case .ending:
                positions[currentPositionIndex].endingMonth = title
            }
        case .year(let rangeType):
            guard row < pickerDataType.rowTitles.count, let currentPositionIndex = currentPositionIndex, currentPositionIndex < positions.count else { return }
            let title = pickerDataType.rowTitles[row]
            switch rangeType {
            case .starting:
                positions[currentPositionIndex].startingYear = title
            case .ending:
                positions[currentPositionIndex].endingYear = title
            }
        }
    }
    
    func onPositionTextCommit(at indexPath: IndexPath, text: String) {
        guard indexPath.row < positions.count else { return }
        positions[indexPath.row].title = text
    }
    
}
