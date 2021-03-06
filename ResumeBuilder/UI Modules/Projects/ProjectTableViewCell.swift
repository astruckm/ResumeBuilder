//
//  ProjectTableViewCell.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var teamSizeTextField: UITextField!
    @IBOutlet weak var projectSummaryTextView: UITextView!
    
    static let reuseID: String = "ProjectTableViewCell"
    var onTextCommitted: ((String, Int) -> Void)?

    func configure(with project: Project, onTextCommitted: @escaping (String, Int) -> Void) {
        projectNameTextField.delegate = self
        teamSizeTextField.delegate = self
        projectSummaryTextView.delegate = self
        self.onTextCommitted = onTextCommitted
        setText(with: project)
    }
    
    func setText(with project: Project) {
        projectNameTextField.text = project.name
        teamSizeTextField.text = project.teamSize
        projectSummaryTextView.text = project.projectSummary
    }
}

extension ProjectTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        onTextCommitted?(textField.text ?? "", textField.tag)
        textField.resignFirstResponder()
    }
}

extension ProjectTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        onTextCommitted?(textView.text ?? "", textView.tag)
    }
}
