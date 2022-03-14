//
//  PreviewViewController.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class PreviewViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var basicInfoLabel: UILabel!
    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var workSummary: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var projectDetailsLabel: UILabel!
    
    let viewModel = PreviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onDone))
        
        viewModel.refresh = {
            DispatchQueue.main.async {
                self.photoImageView.image = self.viewModel.photo
                self.basicInfoLabel.attributedText = self.viewModel.basicInfoText
                self.objectiveLabel.attributedText = self.viewModel.objectiveText
                self.workSummary.attributedText = self.viewModel.workSummaryText
                self.skillsLabel.attributedText = self.viewModel.skillsText
                self.educationLabel.attributedText = self.viewModel.educationText
                self.projectDetailsLabel.attributedText = self.viewModel.projectDetailsText
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    @objc func onDone() {
        self.dismiss(animated: true)
    }



}
