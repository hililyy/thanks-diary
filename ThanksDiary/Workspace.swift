//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by 강조은 on 4/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "ThanksDiary"

let workspace = Workspace(
    name: projectName,
    projects: [
        Module.ThanksDiary.path,
        Module.Presentation.path,
        Module.Domain.path,
        Module.Data.path,
        Module.TdPlus.path,
    ]
)
