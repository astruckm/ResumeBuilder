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
        case .educationStatus: break
        }
        
    }
    
    func onPositionTextCommit(at indexPath: IndexPath, text: String) {
        guard indexPath.row < positions.count else { return }
        positions[indexPath.row].title = text
    }
    
}
