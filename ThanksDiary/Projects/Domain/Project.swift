//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강조은 on 4/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    moduleType: Module.Domain,
    dependencies: [
        Module.TdPlus.project,
        .rxSwift,
    ]
)
