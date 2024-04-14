//
//  Module.swift
//  ProjectDescriptionHelpers
//
//  Created by 강조은 on 4/11/24.
//

import ProjectDescription

public enum Module: String {
    case ThanksDiary
    case Presentation
    case Data
    case Domain
    case TdPlus
    
    public var name: String {
        return self.rawValue
    }
    
    public var path: ProjectDescription.Path {
        return .relativeToRoot("Projects/" + name)
    }
    
    public var project: TargetDependency {
        return .project(target: name, path: path)
    }
}
