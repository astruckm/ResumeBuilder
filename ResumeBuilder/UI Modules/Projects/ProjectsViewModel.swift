//
//  ProjectsViewModel.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/13/22.
//

import UIKit

struct Project {
    var name: String?
    var teamSize: String?
    var projectSummary: String?
}

class ProjectsViewModel {
    let projectRowHeight: CGFloat = 300
    var tableViewHeight: CGFloat {
        projectRowHeight * CGFloat(projects.count)
    }
    var projects: [Project] = []
    var refresh: (() -> Void)?
    
    func addProject() {
        projects.append(Project())
        refresh?()
    }
    
    func onProjectFieldTextCommit(at indexPath: IndexPath, text: String, tag: Int) {
        guard indexPath.row < projects.count else { return }
        if tag == 1 {
            projects[indexPath.row].name = text
        } else if tag == 2 {
            projects[indexPath.row].teamSize = text
        } else if tag == 3 {
            projects[indexPath.row].projectSummary = text
        }
        refresh?()
    }
    
    func saveData() {
        DefaultsManager.saveProjects(projects)
    }
    
    func loadData() {
        projects = DefaultsManager.loadProjects()
        refresh?()
    }
}
