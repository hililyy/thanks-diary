//
//  Dependency+SPM.swift
//  Config
//
//  Created by 강조은 on 4/5/24.
//

import ProjectDescription

public extension TargetDependency {
    static let rxSwift = TargetDependency.package(product: "RxSwift")
    static let rxCocoa = TargetDependency.package(product: "RxCocoa")
    static let rxRelay = TargetDependency.package(product: "RxRelay")
    static let firebaseDatabase = TargetDependency.package(product: "FirebaseDatabase")
    static let firebaseAnalytics = TargetDependency.package(product: "FirebaseAnalytics")
    static let firebaseCrashlytics = TargetDependency.package(product: "FirebaseCrashlytics")
    static let lottie = TargetDependency.package(product: "Lottie")
    static let snapKit = TargetDependency.package(product: "SnapKit")
    static let acknowList = TargetDependency.package(product: "AcknowList")
    static let fSCalendar = TargetDependency.package(product: "FSCalendar")
}

public enum ThirdPartyModule: CaseIterable {
    case RxSwift
    case Firebase
    case Lottie
    case SnapKit
    case AcknowList
    case FSCalendar
    
    public var lib: Package {
        switch self {
        case .RxSwift:
            .remote(url: "https://github.com/ReactiveX/RxSwift", requirement: .upToNextMajor(from: "6.6.0"))
        case .Firebase:
                .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMinor(from: "10.24.0"))
        case .Lottie:
                .remote(url: "https://github.com/airbnb/lottie-ios", requirement: .upToNextMajor(from:"4.4.2"))
        case .SnapKit:
                .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.7.1"))
        case .AcknowList:
                .remote(url: "https://github.com/vtourraine/AcknowList.git", requirement: .upToNextMinor(from: "3.1.0"))
        case .FSCalendar:
                .remote(url: "https://github.com/WenchaoD/FSCalendar.git", requirement: .upToNextMinor(from: "2.8.4"))
        }
    }
}
