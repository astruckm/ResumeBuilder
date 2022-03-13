//
//  ProjectsViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class ProjectsViewController: UIViewController {
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var addProject: UIButton!
    @IBOutlet weak var projectsTableViewHeight: NSLayoutConstraint!
    
    let viewModel = ProjectsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        navigationItem.title = "Projects"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
        viewModel.refresh = {
            DispatchQueue.main.async {
                self.projectsTableView.reloadData()
            }
        }
        projectsTableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: ProjectTableViewCell.reuseID)

    }
    
    @objc func saveButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func addProjectTapped(_ sender: UIButton) {
        viewModel.addProject()
        DispatchQueue.main.async {
            self.projectsTableViewHeight.constant = self.viewModel.tableViewHeight
        }
    }
}

extension ProjectsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.reuseID, for: indexPath) as? ProjectTableViewCell else {
            return UITableViewCell()
        }
        guard indexPath.row < viewModel.projects.count else {
            return UITableViewCell()
        }
        
        let project = viewModel.projects[indexPath.row]
        cell.configure(with: project) { [weak self] text, tag in
            self?.viewModel.onProjectFieldTextCommit(at: indexPath, text: text, tag: tag)
        }
        return cell
    }
    
}

extension ProjectsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.projectRowHeight
    }
}
