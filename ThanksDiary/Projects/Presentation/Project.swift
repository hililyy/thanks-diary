//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강조은 on 4/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    moduleType: Module.Presentation,
    dependencies: [
        Module.Domain.project,
        Module.TdPlus.project,
        .rxSwift,
        .rxCocoa,
        .rxRelay,
        .firebaseDatabase,
        .firebaseAnalytics,
        .firebaseCrashlytics,
        .lottie,
        .fSCalendar,
        .snapKit,
        .acknowList,
    ]
)
