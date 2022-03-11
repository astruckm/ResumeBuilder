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
        print("createNewResumeTapped")
    }
    
    @IBAction func editExistingResume(_ sender: UIButton) {
        print("editExistingResume")
    }
    
}
