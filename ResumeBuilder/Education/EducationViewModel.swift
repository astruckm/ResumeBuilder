//
//  EducationViewModel.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

// View Data for EducationDetailTableViewCell
struct Degree {
    var school: String?
    var status: String?
    var month: String?
    var year: String?
    var gradeAverage: String?
    var educationClass: String?
}

class EducationViewModel {
    let cellHeight: CGFloat = 280
    var tableViewHeight: CGFloat {
        cellHeight * CGFloat(degrees.count)
    }
    var pickerDataType: PickerDataType = .yearsExperience
    var currentPositionIndex: Int?
    var degrees: [Degree] = []
    var refresh: (() -> Void)?
    
    func addDegree() {
        degrees.append(Degree())
        refresh?()
    }
    
    func onEducationDetailTextCommit(at indexPath: IndexPath, text: String, tag: Int) {
        guard indexPath.row < degrees.count else { return }
        if tag == 1 {
            degrees[indexPath.row].school = text
        } else if tag == 2 {
            degrees[indexPath.row].gradeAverage = text
        } else if tag == 3 {
            degrees[indexPath.row].educationClass = text
        }
    }
    
    func onPositionTimeTap(at indexPath: IndexPath, pickerDataType pickerType: PickerDataType) {
        currentPositionIndex = indexPath.row
        pickerDataType = pickerType
    }
    
    func onSelectPicker(row: Int) {
        guard row < pickerDataType.rowTitles.count else { return }
        guard let currentPositionIndex = currentPositionIndex else { return }
        guard currentPositionIndex < degrees.count else { return }
        let title = pickerDataType.rowTitles[row]
        
        switch pickerDataType {
        case .yearsExperience: break
        case .month(_):
            degrees[currentPositionIndex].month = title
        case .year(_):
            degrees[currentPositionIndex].year = title
        case .educationStatus:
            degrees[currentPositionIndex].status = title
        }
        
        refresh?()
    }
    
    func saveData() {
        DefaultsManager.saveDegrees(degrees)
    }
    
    func loadData() {
        degrees = DefaultsManager.loadDegrees()
        refresh?()
    }

}
