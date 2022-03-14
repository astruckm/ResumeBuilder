//
//  DefaultsManager.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/14/22.
//

import Foundation

class DefaultsManager {
    static func saveWorkPositions(_ positions: [WorkPosition]) {
        var positionsDicts: [[String: String]] = []
        for position in positions {
            var positionDict: [String: String] = [:]
            positionDict["startingMonth"] = position.startingMonth
            positionDict["startingYear"] = position.startingYear
            positionDict["endingMonth"] = position.endingMonth
            positionDict["endingYear"] = position.endingYear
            positionDict["title"] = position.title
            positionsDicts.append(positionDict)
        }
        UserDefaults.standard.set(positionsDicts, forKey: DefaultsKeys.workExperience)
    }
    
    static func loadWorkPositions() -> [WorkPosition] {
        guard let positionsDicts = UserDefaults.standard.value(forKey: DefaultsKeys.workExperience) as? [[String: String]] else { return [] }
        var positions = [WorkPosition]()
        for positionDict in positionsDicts {
            var position = WorkPosition()
            position.startingMonth = positionDict["startingMonth"]
            position.startingYear = positionDict["startingYear"]
            position.endingMonth = positionDict["endingMonth"]
            position.endingYear = positionDict["endingYear"]
            position.title = positionDict["title"]
            positions.append(position)
        }
        return positions
    }
    
    static func saveDegrees(_ degrees: [Degree]) {
        var degreesDicts: [[String: String]] = []
        for degree in degrees {
            var degreeDict: [String: String] = [:]
            degreeDict["school"] = degree.school
            degreeDict["status"] = degree.status
            degreeDict["month"] = degree.status
            degreeDict["year"] = degree.year
            degreeDict["gradeAverage"] = degree.gradeAverage
            degreeDict["educationClass"] = degree.educationClass
            degreesDicts.append(degreeDict)
        }
        UserDefaults.standard.set(degreesDicts, forKey: DefaultsKeys.degrees)
    }
    
    static func loadDegrees() -> [Degree] {
        guard let degreeDicts = UserDefaults.standard.value(forKey: DefaultsKeys.degrees) as? [[String: String]] else { return [] }
        var degrees = [Degree]()
        for degreeDict in degreeDicts {
            var degree = Degree()
            degree.school = degreeDict["school"]
            degree.status = degreeDict["status"]
            degree.status = degreeDict["month"]
            degree.year = degreeDict["year"]
            degree.gradeAverage = degreeDict["gradeAverage"]
            degree.educationClass = degreeDict["educationClass"]
            degrees.append(degree)
        }
        return degrees
    }
        
    static func saveProjects(_ projects: [Project]) {
        var projectsDicts: [[String: String]] = []
        for project in projects {
            var projectDict: [String: String] = [:]
            projectDict["name"] = project.name
            projectDict["teamSize"] = project.teamSize
            projectDict["projectSummary"] = project.projectSummary
            projectsDicts.append(projectDict)
        }
        UserDefaults.standard.set(projectsDicts, forKey: DefaultsKeys.projects)
    }
    
    static func loadProjects() -> [Project] {
        guard let projectsDicts = UserDefaults.standard.value(forKey: DefaultsKeys.projects) as? [[String: String]] else { return [] }
        var projects = [Project]()
        for projectDict in projectsDicts {
            var project = Project()
            project.name = projectDict["name"]
            project.teamSize = projectDict["teamSize"]
            project.projectSummary = projectDict["projectSummary"]
            projects.append(project)
        }
        return projects
    }
    
    static func resetDefaults() {
        let defaultsDict = UserDefaults.standard.dictionaryRepresentation()
        defaultsDict.keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
    }

}
