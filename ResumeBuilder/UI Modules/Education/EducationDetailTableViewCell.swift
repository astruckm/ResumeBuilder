//
//  EducationDetailTableViewCell.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class EducationDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var cgpaTextField: UITextField!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var status: UIButton!
    @IBOutlet weak var month: UIButton!
    @IBOutlet weak var year: UIButton!
    
    static let reuseID: String = "EducationDetailTableViewCell"
    var onTextCommitted: ((String, Int) -> Void)?
    var onDegreeStatusTapped: ((PickerDataType) -> Void)?
    
    func configure(with degree: Degree, onTextCommitted: @escaping ((String, Int) -> Void), onDegreeStatusTapped: @escaping ((PickerDataType) -> Void)) {
        schoolTextField.delegate = self
        cgpaTextField.delegate = self
        classTextField.delegate = self
        self.onTextCommitted = onTextCommitted
        self.onDegreeStatusTapped = onDegreeStatusTapped
        
        setText(with: degree)
        setImages(with: degree)
    }
    
    func setText(with degree: Degree) {
        schoolTextField.text = degree.school
        cgpaTextField.text = degree.gradeAverage
        classTextField.text = degree.educationClass
        status.setTitle(degree.status, for: .normal)
        month.setTitle(degree.month, for: .normal)
        year.setTitle(degree.year, for: .normal)
    }
    
    func setImages(with degree: Degree) {
        let downArrow: UIImage? = UIImage(systemName: "chevron.down")
        status.setImage(degree.status == nil ? downArrow : UIImage(), for: .normal)
        month.setImage(degree.month == nil ? downArrow : UIImage(), for: .normal)
        year.setImage(degree.year == nil ? downArrow : UIImage(), for: .normal)
    }
    
    @IBAction func statusTapped(_ sender: UIButton) {
        onDegreeStatusTapped?(PickerDataType.educationStatus)
    }
    
    @IBAction func monthTapped(_ sender: UIButton) {
        onDegreeStatusTapped?(PickerDataType.month(.ending))
    }
    
    @IBAction func yearTapped(_ sender: UIButton) {
        onDegreeStatusTapped?(PickerDataType.year(.ending))
    }
    
}

extension EducationDetailTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
        onTextCommitted?(textField.text ?? "", textField.tag)
    }
}
