//
//  SectionTableViewCell.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/12/22.
//

import UIKit

class SectionTableViewCell: UITableViewCell {
    @IBOutlet weak var sectionName: UILabel!
    
    static let reuseID: String = "SectionTableViewCell"
    
    func configure(with viewData: SectionsListViewModel.SectionType) {
        sectionName.text = viewData.rawValue
    }
    
}
