import ProjectDescription

extension Project {
    static let identifier = "com.lily.Thanks-Diary"
    static let deploymentTargets: DeploymentTargets = .iOS("14.0")
    
    public static func makeModule(
        moduleType: Module,
        resources: ProjectDescription.ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        package: [Package] = []
    ) -> Project {
        
        return .project(
            moduleType: moduleType,
            resources: resources,
            dependencies: dependencies,
            package: package
        )
    }
    
    static func project(
        moduleType: Module,
        resources: ProjectDescription.ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        package: [Package] = []
    ) -> Project {
        let myProduct: Product = moduleType == .ThanksDiary ? .app : .staticFramework
        let myBundleID: String = moduleType == .ThanksDiary ? identifier : identifier + ".\(moduleType.name)"
        let target = [
            Target(
                name: moduleType.name,
                destinations: .iOS,
                product: myProduct,
                bundleId: myBundleID,
                deploymentTargets: deploymentTargets,
                infoPlist: .file(
                    path: .relativeToRoot("Plist/Info.plist")
                ),
                sources: ["Sources/**"],
                resources: resources,
                dependencies: dependencies
            )
        ]
        
        return Project(
            name: moduleType.name,
            packages: package,
            targets: target
        )
    }
}
