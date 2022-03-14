//
//  SelectResumeViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/11/22.
//

import UIKit

class SelectResumeViewController: UIViewController {
    @IBOutlet weak var createNew: UIButton!
    @IBOutlet weak var editExisting: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func createNewResumeTapped(_ sender: UIButton) {
        let sectionsListVC = SectionsListViewController(nibName: "SectionsListViewController", bundle: nil)
        DefaultsManager.resetDefaults()
        self.navigationController?.pushViewController(sectionsListVC, animated: true)
    }
    
    @IBAction func editExistingResume(_ sender: UIButton) {
        let sectionsListVC = SectionsListViewController(nibName: "SectionsListViewController", bundle: nil)
        self.navigationController?.pushViewController(sectionsListVC, animated: true)
    }
    
}
