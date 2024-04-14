//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강조은 on 4/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    moduleType: Module.ThanksDiary,
    resources: .default,
    dependencies: [
        Module.Presentation.project
    ],
    package: ThirdPartyModule.allCases.map(\.lib)
)

public extension ProjectDescription.ResourceFileElements {
    static let `default`: ProjectDescription.ResourceFileElements = ["Resources/**"]
}
