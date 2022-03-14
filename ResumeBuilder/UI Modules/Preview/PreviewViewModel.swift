//
//  PreviewViewModel.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/14/22.
//

import UIKit

class PreviewViewModel {
    let headerFont = UIFont.boldSystemFont(ofSize: 18)
    var basicInfoText: NSAttributedString?
    var photo: UIImage?
    var objectiveText: NSAttributedString?
    var workSummaryText: NSAttributedString?
    var skillsText: NSAttributedString?
    var educationText: NSAttributedString?
    var projectDetailsText: NSAttributedString?
    
    var refresh: (() -> Void)?
    
    func loadData() {
        setBasicInfoText()
        setCareerText()
        setSkillsText()
        setEducationText()
        setProjectDetails()
        
        refresh?()
    }
    
    func setBasicInfoText() {
        let name = UserDefaults.standard.string(forKey: DefaultsKeys.name) ?? ""
        let address = UserDefaults.standard.string(forKey: DefaultsKeys.address) ?? ""
        let phoneNumber = UserDefaults.standard.string(forKey: DefaultsKeys.phoneNumber) ?? ""
        let email = UserDefaults.standard.string(forKey: DefaultsKeys.email) ?? ""
        basicInfoText = makeBasicInfoText(name: name, address: address, phoneNumber: phoneNumber, email: email)
        
        if let photoData = UserDefaults.standard.data(forKey: DefaultsKeys.photo) {
            photo = UIImage(data: photoData)
        }
    }
        
    func setCareerText() {
        let objective = UserDefaults.standard.string(forKey: DefaultsKeys.objective) ?? ""
        objectiveText = makeCareerObjectiveText(objective)
        
//        let yearsExperience = UserDefaults.standard.integer(forKey: DefaultsKeys.yearsExperience)
        let positions = DefaultsManager.loadWorkPositions()
        workSummaryText = makeWorkSummaryText(positions)
    }
    
    
    func setSkillsText() {
        if let skills = UserDefaults.standard.value(forKey: DefaultsKeys.skills) as? [String] {
            skillsText = makeSkillsText(skills)
        }
    }
    
    func setEducationText() {
        let degrees = DefaultsManager.loadDegrees()
        educationText = makeEducationText(degrees)
    }
    
    func setProjectDetails() {
        let projects = DefaultsManager.loadProjects()
        projectDetailsText = makeProjectDetailsText(projects)
    }
}

extension PreviewViewModel {
    func makeBasicInfoText(name: String, address: String, phoneNumber: String, email: String) -> NSAttributedString {
        let basicInfoText: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        let nameAttributes = [NSAttributedString.Key.font: headerFont]
        let attributedName = NSAttributedString(string: name, attributes: nameAttributes)
        basicInfoText.append(attributedName)
        basicInfoText.append(NSAttributedString(string: "\n"))
        basicInfoText.append(NSAttributedString(string: "\(address)\n"))
        basicInfoText.append(NSAttributedString(string: "\(phoneNumber)\n"))
        basicInfoText.append(NSAttributedString(string: email))
        
        return basicInfoText
    }
    
    func makeCareerObjectiveText(_ objectiveText: String) -> NSAttributedString {
        let careerObjectiveText: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        let objectiveHeaderAttributes: [NSAttributedString.Key: Any] = [.font: headerFont]
        let attributedHeader = NSAttributedString(string: "Career Objective", attributes: objectiveHeaderAttributes)
        careerObjectiveText.append(attributedHeader)
        careerObjectiveText.append(NSAttributedString(string: "\n"))
        careerObjectiveText.append(NSAttributedString(string: objectiveText))
        
        return careerObjectiveText
    }
    
    func makeWorkSummaryText(_ positions: [WorkPosition]) -> NSAttributedString {
        let workSummaryText: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        let workSummaryHeaderAttributes: [NSAttributedString.Key: Any] = [.font: headerFont]
        let attributedHeader = NSAttributedString(string: "Work Summary", attributes: workSummaryHeaderAttributes)
        workSummaryText.append(attributedHeader)
        workSummaryText.append(NSAttributedString(string: "\n"))
        for position in positions {
            let positionStr = (position.startingMonth ?? "") + " " + (position.startingYear ?? "") + " - " + (position.endingMonth ?? "") + " " + (position.endingYear ?? "") + "\t" + (position.title ?? "")
            workSummaryText.append(NSAttributedString(string: positionStr))
        }

        return workSummaryText
    }
    
    func makeSkillsText(_ skills: [String]) -> NSAttributedString {
        let skillsText: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        let skillsHeaderAttributes: [NSMutableAttributedString.Key: Any] = [.font: headerFont]
        let attributedHeader = NSAttributedString(string: "Skills", attributes: skillsHeaderAttributes)
        skillsText.append(attributedHeader)
        skillsText.append(NSAttributedString(string: "\n"))
        for skill in skills {
            skillsText.append(NSAttributedString(string: "• \(skill)\n"))
        }
        
        return skillsText
    }
    
    func makeEducationText(_ degrees: [Degree]) -> NSAttributedString {
        let educationText: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        let educationHeaderAttributes: [NSAttributedString.Key: Any] = [.font: headerFont]
        let attributedHeader = NSAttributedString(string: "Education", attributes: educationHeaderAttributes)
        educationText.append(attributedHeader)
        educationText.append(NSAttributedString(string: "\n"))
        for degree in degrees {
            let degreeStr = (degree.year ?? "") + "\t" + (degree.school ?? "") + " " + (degree.educationClass ?? "") + " " + (degree.gradeAverage ?? "") + (degree.status == nil ? "" : ", " + (degree.status ?? ""))
            educationText.append(NSAttributedString(string: degreeStr))
        }

        return educationText
    }
    
    func makeProjectDetailsText(_ projects: [Project]) -> NSAttributedString {
        let projectDetailsText: NSMutableAttributedString = NSMutableAttributedString(string: "")
        
        let projectDetailsAttributes: [NSAttributedString.Key: Any] = [.font: headerFont]
        let attributedHeader = NSAttributedString(string: "Project Details", attributes: projectDetailsAttributes)
        projectDetailsText.append(attributedHeader)
        projectDetailsText.append(NSAttributedString(string: "\n"))
        for project in projects {
            let projectStr = (project.name ?? "") + " " + (project.teamSize == nil ? "" : "(\(project.teamSize ?? "")") + "\n\t" + "\(project.projectSummary ?? "")"
            projectDetailsText.append(NSAttributedString(string: projectStr))
        }
        
        return projectDetailsText
    }

}
