//
//  SkillsViewModel.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

class SkillsViewModel {
    var skills: [String] = []
    var refresh: (() -> Void)?
    
    func addNewSkill(_ text: String?) {
        guard let text = text else { return }
        skills.append(text)
        refresh?()
    }
}
