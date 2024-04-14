//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강조은 on 4/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    moduleType: Module.Data,
    dependencies: [
        Module.Domain.project,
        Module.TdPlus.project
    ]
)
