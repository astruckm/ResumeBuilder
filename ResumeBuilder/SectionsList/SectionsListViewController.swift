//
//  SectionsListViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/12/22.
//

import UIKit

class SectionsListViewController: UIViewController {
    @IBOutlet weak var sectionListTableView: UITableView!
    
    let viewModel = SectionsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        sectionListTableView.register(UINib(nibName: "SectionTableViewCell", bundle: nil), forCellReuseIdentifier: SectionTableViewCell.reuseID)
    }

    func coordinateNavigation(for screenType: SectionsListViewModel.SectionType) {
        switch screenType {
        case .basicInfo:
            let basicInfoVC = BasicInfoViewController(nibName: "BasicInfoViewController", bundle: nil)
            navigationController?.pushViewController(basicInfoVC, animated: true)
        case .career: break
        case .education: break
        case .skills: break
        case .projects: break
        }
    }
    
}

extension SectionsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionsListViewModel.SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SectionTableViewCell.reuseID, for: indexPath) as? SectionTableViewCell else {
            return UITableViewCell()
        }
        let allSectionTypes = SectionsListViewModel.SectionType.allCases
        guard indexPath.row < allSectionTypes.count else {
            return UITableViewCell()
        }
        
        cell.configure(with: allSectionTypes[indexPath.row])
        return cell
    }
    
    
}

extension SectionsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < SectionsListViewModel.SectionType.allCases.count else { return }
        let sectionType = SectionsListViewModel.SectionType.allCases[indexPath.row]
        coordinateNavigation(for: sectionType)
    }
}
