// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length line_length implicit_return

// MARK: - Files

// swiftlint:disable explicit_type_interface identifier_name
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Files {
  /// dot.json
  internal static let dotJson = File(name: "dot", ext: "json", relativePath: "", mimeType: "application/json")
  /// go.json
  internal static let goJson = File(name: "go", ext: "json", relativePath: "", mimeType: "application/json")
  /// plant.json
  internal static let plantJson = File(name: "plant", ext: "json", relativePath: "", mimeType: "application/json")
  /// sun.json
  internal static let sunJson = File(name: "sun", ext: "json", relativePath: "", mimeType: "application/json")
  /// wave.json
  internal static let waveJson = File(name: "wave", ext: "json", relativePath: "", mimeType: "application/json")
  /// writing.json
  internal static let writingJson = File(name: "writing", ext: "json", relativePath: "", mimeType: "application/json")
}
// swiftlint:enable explicit_type_interface identifier_name
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

internal struct File {
  internal let name: String
  internal let ext: String?
  internal let relativePath: String
  internal let mimeType: String

  internal var url: URL {
    return url(locale: nil)
  }

  internal func url(locale: Locale?) -> URL {
    let bundle = BundleToken.bundle
    let url = bundle.url(
      forResource: name,
      withExtension: ext,
      subdirectory: relativePath,
      localization: locale?.identifier
    )
    guard let result = url else {
      let file = name + (ext.flatMap { ".\($0)" } ?? "")
      fatalError("Could not locate file named \(file)")
    }
    return result
  }

  internal var path: String {
    return path(locale: nil)
  }

  internal func path(locale: Locale?) -> String {
    return url(locale: locale).path
  }
}

// swiftlint:disable convenience_type explicit_type_interface
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type explicit_type_interface
