//
//  SkillsViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class SkillsViewController: UIViewController {
    @IBOutlet weak var skillTextField: UITextField!
    @IBOutlet weak var skillsTableView: UITableView!
    
    let viewModel = SkillsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        navigationItem.title = "Skills"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
        skillTextField.delegate = self
        skillsTableView.register(UINib(nibName: "SkillTableViewCell", bundle: nil), forCellReuseIdentifier: SkillTableViewCell.reuseID)
        viewModel.refresh = {
            DispatchQueue.main.async {
                self.skillsTableView.reloadData()
            }
        }
    }
    
    @objc func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}

extension SkillsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.addNewSkill(textField.text)
        textField.text = nil
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

extension SkillsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SkillTableViewCell.reuseID, for: indexPath) as? SkillTableViewCell else {
            return UITableViewCell()
        }
        guard indexPath.row < viewModel.skills.count else { return UITableViewCell() }
        let skill = viewModel.skills[indexPath.row]
        cell.textLabel?.text = "• " + skill
        return cell
    }
    
}

extension SkillsViewController: UITableViewDelegate {
    
}
