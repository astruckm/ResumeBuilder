//
//  EducationViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class EducationViewController: UIViewController {
    @IBOutlet weak var educationTableView: UITableView!
    @IBOutlet weak var addEducation: UIButton!
    @IBOutlet weak var educationTableViewHeight: NSLayoutConstraint!
    
    let viewModel = EducationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        navigationItem.title = "Education"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
        viewModel.refresh = {
            DispatchQueue.main.async {
                self.educationTableView.reloadData()
            }
        }
        educationTableView.register(UINib(nibName: "EducationDetailTableViewCell", bundle: nil), forCellReuseIdentifier: EducationDetailTableViewCell.reuseID)
    }
    
    @IBAction func addEducationTapped(_ sender: UIButton) {
        viewModel.addDegree()
        DispatchQueue.main.async {
            self.educationTableViewHeight.constant = self.viewModel.tableViewHeight
        }
    }
    
    @objc func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentPicker() {
        let presenterVC = UIViewController()
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        presenterVC.view = picker
        present(presenterVC, animated: true)
    }
    
}

extension EducationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.degrees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EducationDetailTableViewCell.reuseID, for: indexPath) as? EducationDetailTableViewCell else {
            return UITableViewCell()
        }
        guard indexPath.row < viewModel.degrees.count else {
            return UITableViewCell()
        }
        
        let degree = viewModel.degrees[indexPath.row]
        cell.configure(with: degree, onTextCommitted: { [weak self] text, tag in
            self?.viewModel.onEducationDetailTextCommit(at: indexPath, text: text, tag: tag)
        }) { [weak self] pickerType in
            self?.viewModel.onPositionTimeTap(at: indexPath, pickerDataType: pickerType)
            self?.presentPicker()
        }
        return cell
    }
    
    
}

extension EducationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight
    }
}

extension EducationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.pickerDataType.rowTitles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard row < viewModel.pickerDataType.rowTitles.count else { return nil }
        return viewModel.pickerDataType.rowTitles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        dismiss(animated: false)
        viewModel.onSelectPicker(row: row)
    }

}
