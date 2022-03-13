//
//  CareerViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/12/22.
//

import UIKit

class CareerViewController: UIViewController {
    @IBOutlet weak var objectiveTextField: UITextField!
    @IBOutlet weak var yearsExperience: UIButton!
    @IBOutlet weak var positionsTableView: UITableView!
    @IBOutlet weak var addPosition: UIButton!
    
    @IBOutlet weak var positionsTableViewHeight: NSLayoutConstraint!
    
    let viewModel = CareerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        positionsTableView.register(UINib(nibName: "PositionTableViewCell", bundle: nil), forCellReuseIdentifier: PositionTableViewCell.reuseID)
        setupUI()
        loadData()
    }
    
    func setupUI() {
        navigationItem.title = "Career"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
        objectiveTextField.addSpaceBeforeText()
        yearsExperience.configuration?.imagePadding = 12
        addPosition.configuration?.imagePadding = 12
    }
    
    func loadData() {
        
    }
    
    @objc func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }


    @IBAction func yearsExperienceTapped(_ sender: UIButton) {
        viewModel.onYearsExperienceTap()
        presentPicker()
    }
    
    @IBAction func addPositionTapped(_ sender: UIButton) {
        viewModel.positions.append(WorkPosition())
        DispatchQueue.main.async {
            self.positionsTableViewHeight.constant = self.viewModel.positionsTableViewHeight
            self.positionsTableView.reloadData()
        }
    }
    
    func presentPicker() {
        let presenterVC = UIViewController()
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        presenterVC.view = picker
        present(presenterVC, animated: true)
    }
    
    func updateUIFromPicker() {
        if viewModel.pickerDataType == PickerDataType.yearsExperience {
            DispatchQueue.main.async {
                self.yearsExperience.setTitle(String(String(self.viewModel.selectedYearsExperience ?? 0)), for: .normal)
            }
        } else {
            DispatchQueue.main.async {
                self.positionsTableView.reloadData()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension CareerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.objective = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.objective = textField.text
        textField.resignFirstResponder()
    }
    
}

extension CareerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        updateUIFromPicker()
    }
}

extension CareerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.positions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PositionTableViewCell.reuseID, for: indexPath) as? PositionTableViewCell else {
            return UITableViewCell()
        }
        guard indexPath.row < viewModel.positions.count else {
            return UITableViewCell()
        }
        
        let workPosition = viewModel.positions[indexPath.row]
        cell.configure(with: workPosition, onDateTapped: { [weak self] pickerType in
            self?.viewModel.onPositionTimeTap(at: indexPath, pickerDataType: pickerType)
            self?.presentPicker()
        }) { [weak self] text in
            self?.viewModel.onPositionTextCommit(at: indexPath, text: text)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.positionRowHeight
    }
}

