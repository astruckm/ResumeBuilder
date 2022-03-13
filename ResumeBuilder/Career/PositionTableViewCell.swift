//
//  PositionTableViewCell.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/12/22.
//

import UIKit

class PositionTableViewCell: UITableViewCell {
    @IBOutlet weak var startMonth: UIButton!
    @IBOutlet weak var endMonth: UIButton!
    @IBOutlet weak var startYear: UIButton!
    @IBOutlet weak var endYear: UIButton!
    @IBOutlet weak var companyPosition: UITextField!
    
    static let reuseID: String = "PositionTableViewCell"
    var onDateTapped: ((PickerDataType) -> Void)?
    var onTextCommitted: ((String) -> Void)?

    func configure(with viewData: WorkPosition,
                   onDateTapped: @escaping ((PickerDataType) -> Void),
                   onTextCommitted: @escaping ((String) -> Void)) {
        self.startMonth.setTitle(viewData.startingMonth, for: .normal)
        self.endMonth.setTitle(viewData.endingMonth, for: .normal)
        self.startYear.setTitle(viewData.startingYear, for: .normal)
        self.endYear.setTitle(viewData.endingYear, for: .normal)
        self.onDateTapped = onDateTapped
        self.companyPosition.delegate = self
        self.onTextCommitted = onTextCommitted
        self.setImages(with: viewData)
    }
    
    func setImages(with viewData: WorkPosition) {
        let downArrow: UIImage? = UIImage(systemName: "chevron.down")
        self.startMonth.setImage(viewData.startingMonth == nil ? downArrow : UIImage(), for: .normal)
        self.endMonth.setImage(viewData.endingMonth == nil ? downArrow : UIImage(), for: .normal)
        self.startYear.setImage(viewData.startingYear == nil ? downArrow : UIImage(), for: .normal)
        self.endYear.setImage(viewData.endingYear == nil ? downArrow : UIImage(), for: .normal)
    }
        
    @IBAction func startMonthTapped(_ sender: UIButton) {
        onDateTapped?(.month(.starting))
    }
    
    @IBAction func endMonthTapped(_ sender: UIButton) {
        onDateTapped?(.month(.ending))
    }
    
    @IBAction func startYearTapped(_ sender: UIButton) {
        onDateTapped?(.year(.starting))
    }
    
    @IBAction func endYearTapped(_ sender: UIButton) {
        onDateTapped?(.year(.ending))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
}

extension PositionTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onTextCommitted?(textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        onTextCommitted?(textField.text ?? "")
        textField.resignFirstResponder()
    }

}
