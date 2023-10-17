// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Color {
    internal static let blackColor = ColorAsset(name: "blackColor")
    internal static let gray1 = ColorAsset(name: "gray1")
    internal static let gray2 = ColorAsset(name: "gray2")
    internal static let gray3 = ColorAsset(name: "gray3")
    internal static let gray4 = ColorAsset(name: "gray4")
    internal static let gray5 = ColorAsset(name: "gray5")
    internal static let gray6 = ColorAsset(name: "gray6")
    internal static let gray7 = ColorAsset(name: "gray7")
    internal static let gray8 = ColorAsset(name: "gray8")
    internal static let gray9 = ColorAsset(name: "gray9")
    internal static let grayBlue = ColorAsset(name: "grayBlue")
    internal static let green = ColorAsset(name: "green")
    internal static let lightGrayBlue = ColorAsset(name: "lightGrayBlue")
    internal static let pink = ColorAsset(name: "pink")
    internal static let purple = ColorAsset(name: "purple")
    internal static let red = ColorAsset(name: "red")
    internal static let white = ColorAsset(name: "white")
    internal static let yellow = ColorAsset(name: "yellow")
  }
  internal enum Image {
    internal static let icBack = ImageAsset(name: "ic_back")
    internal static let icBlueDot12 = ImageAsset(name: "ic_blue_dot_12")
    internal static let icBlueDot20 = ImageAsset(name: "ic_blue_dot_20")
    internal static let icCircle = ImageAsset(name: "ic_circle")
    internal static let icDelete = ImageAsset(name: "ic_delete")
    internal static let icDetailWrite = ImageAsset(name: "ic_detail_write")
    internal static let icDetailWriteGreen = ImageAsset(name: "ic_detail_write_green")
    internal static let icDetailWritePink = ImageAsset(name: "ic_detail_write_pink")
    internal static let icDetailWritePurple = ImageAsset(name: "ic_detail_write_purple")
    internal static let icDetailWriteYellow = ImageAsset(name: "ic_detail_write_yellow")
    internal static let icEight = ImageAsset(name: "ic_eight")
    internal static let icFive = ImageAsset(name: "ic_five")
    internal static let icFour = ImageAsset(name: "ic_four")
    internal static let icGrayDot12 = ImageAsset(name: "ic_gray_dot_12")
    internal static let icGrayDot20 = ImageAsset(name: "ic_gray_dot_20")
    internal static let icMail = ImageAsset(name: "ic_mail")
    internal static let icMore = ImageAsset(name: "ic_more")
    internal static let icNine = ImageAsset(name: "ic_nine")
    internal static let icOne = ImageAsset(name: "ic_one")
    internal static let icPencil = ImageAsset(name: "ic_pencil")
    internal static let icPlus = ImageAsset(name: "ic_plus")
    internal static let icSetting = ImageAsset(name: "ic_setting")
    internal static let icSeven = ImageAsset(name: "ic_seven")
    internal static let icSimpleWrite = ImageAsset(name: "ic_simple_write")
    internal static let icSimpleWriteGreen = ImageAsset(name: "ic_simple_write_green")
    internal static let icSimpleWritePink = ImageAsset(name: "ic_simple_write_pink")
    internal static let icSimpleWritePurple = ImageAsset(name: "ic_simple_write_purple")
    internal static let icSimpleWriteYellow = ImageAsset(name: "ic_simple_write_yellow")
    internal static let icSix = ImageAsset(name: "ic_six")
    internal static let icThree = ImageAsset(name: "ic_three")
    internal static let icTrash = ImageAsset(name: "ic_trash")
    internal static let icTwo = ImageAsset(name: "ic_two")
    internal static let icWrite = ImageAsset(name: "ic_write")
    internal static let icX = ImageAsset(name: "ic_x")
    internal static let icZero = ImageAsset(name: "ic_zero")
    internal static let imgHeart = ImageAsset(name: "img_heart")
    internal static let imgLock = ImageAsset(name: "img_lock")
    internal static let imgSystemTheme = ImageAsset(name: "img_system_theme")
    internal static let imgUnderline = ImageAsset(name: "img_underline")
    internal static let imgUnderlineBlue = ImageAsset(name: "img_underline_blue")
    internal static let imgUnderlineGreen = ImageAsset(name: "img_underline_green")
    internal static let imgUnderlinePink = ImageAsset(name: "img_underline_pink")
    internal static let imgUnderlineYellow = ImageAsset(name: "img_underline_yellow")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
