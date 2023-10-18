// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "FontConvertible.Font", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias Font = FontConvertible.Font

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum KotraHope {
    internal static let regular = FontConvertible(name: "KOTRA-HOPE", family: "KOTRA HOPE", path: "KOTRAHOPE.ttf")
    internal static let all: [FontConvertible] = [regular]
  }
  internal enum KotraGothic {
    internal static let regular = FontConvertible(name: "KOTRA_GOTHIC", family: "KOTRA_GOTHIC", path: "KOTRA_GOTHIC.ttf")
    internal static let all: [FontConvertible] = [regular]
  }
  internal enum NanumBarunGothic {
    internal static let regular = FontConvertible(name: "NanumBarunGothic", family: "NanumBarunGothic", path: "NanumBarunGothic.ttf")
    internal static let bold = FontConvertible(name: "NanumBarunGothicBold", family: "NanumBarunGothic", path: "NanumBarunGothicBold.ttf")
    internal static let light = FontConvertible(name: "NanumBarunGothicLight", family: "NanumBarunGothic", path: "NanumBarunGothicLight.ttf")
    internal static let ultraLight = FontConvertible(name: "NanumBarunGothicUltraLight", family: "NanumBarunGothic", path: "NanumBarunGothicUltraLight.ttf")
    internal static let all: [FontConvertible] = [regular, bold, light, ultraLight]
  }
  internal enum OwnglyphHaruNanum {
    internal static let regular = FontConvertible(name: "Ownglyph_haru_nanum-Rg", family: "Ownglyph haru nanum", path: "halunanum.ttf")
    internal static let all: [FontConvertible] = [regular]
  }
  internal enum OwnglyphWiri {
    internal static let regular = FontConvertible(name: "Ownglyph_wiri-Rg", family: "Ownglyph wiri", path: "wiri.ttf")
    internal static let all: [FontConvertible] = [regular]
  }
  internal enum Pretendard {
    internal static let black = FontConvertible(name: "Pretendard-Black", family: "Pretendard", path: "Pretendard-Black.otf")
    internal static let bold = FontConvertible(name: "Pretendard-Bold", family: "Pretendard", path: "Pretendard-Bold.otf")
    internal static let extraBold = FontConvertible(name: "Pretendard-ExtraBold", family: "Pretendard", path: "Pretendard-ExtraBold.otf")
    internal static let extraLight = FontConvertible(name: "Pretendard-ExtraLight", family: "Pretendard", path: "Pretendard-ExtraLight.otf")
    internal static let light = FontConvertible(name: "Pretendard-Light", family: "Pretendard", path: "Pretendard-Light.otf")
    internal static let medium = FontConvertible(name: "Pretendard-Medium", family: "Pretendard", path: "Pretendard-Medium.otf")
    internal static let regular = FontConvertible(name: "Pretendard-Regular", family: "Pretendard", path: "Pretendard-Regular.otf")
    internal static let semiBold = FontConvertible(name: "Pretendard-SemiBold", family: "Pretendard", path: "Pretendard-SemiBold.otf")
    internal static let thin = FontConvertible(name: "Pretendard-Thin", family: "Pretendard", path: "Pretendard-Thin.otf")
    internal static let all: [FontConvertible] = [black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin]
  }
  internal enum SCoreDream {
    internal static let _1Thin = FontConvertible(name: "S-CoreDream-1Thin", family: "S-Core Dream", path: "SCDream1.otf")
    internal static let _2ExtraLight = FontConvertible(name: "S-CoreDream-2ExtraLight", family: "S-Core Dream", path: "SCDream2.otf")
    internal static let _3Light = FontConvertible(name: "S-CoreDream-3Light", family: "S-Core Dream", path: "SCDream3.otf")
    internal static let _4Regular = FontConvertible(name: "S-CoreDream-4Regular", family: "S-Core Dream", path: "SCDream4.otf")
    internal static let _5Medium = FontConvertible(name: "S-CoreDream-5Medium", family: "S-Core Dream", path: "SCDream5.otf")
    internal static let _6Bold = FontConvertible(name: "S-CoreDream-6Bold", family: "S-Core Dream", path: "SCDream6.otf")
    internal static let _7ExtraBold = FontConvertible(name: "S-CoreDream-7ExtraBold", family: "S-Core Dream", path: "SCDream7.otf")
    internal static let _8Heavy = FontConvertible(name: "S-CoreDream-8Heavy", family: "S-Core Dream", path: "SCDream8.otf")
    internal static let _9Black = FontConvertible(name: "S-CoreDream-9Black", family: "S-Core Dream", path: "SCDream9.otf")
    internal static let all: [FontConvertible] = [_1Thin, _2ExtraLight, _3Light, _4Regular, _5Medium, _6Bold, _7ExtraBold, _8Heavy, _9Black]
  }
  internal enum 온글잎안될과학유니랩장체 {
    internal static let regular = FontConvertible(name: "Unreal_science_yuni", family: "온글잎 안될과학유니랩장체", path: "UniLab.ttf")
    internal static let all: [FontConvertible] = [regular]
  }
  internal static let allCustomFonts: [FontConvertible] = [KotraHope.all, KotraGothic.all, NanumBarunGothic.all, OwnglyphHaruNanum.all, OwnglyphWiri.all, Pretendard.all, SCoreDream.all, 온글잎안될과학유니랩장체.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  internal func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(fixedSize: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, fixedSize: fixedSize)
  }

  @available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
  internal func swiftUIFont(size: CGFloat, relativeTo textStyle: SwiftUI.Font.TextStyle) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: size, relativeTo: textStyle)
  }
  #endif

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
    #elseif os(macOS)
    if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      register()
    }
    #endif
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
}

@available(iOS 14.0, tvOS 14.0, watchOS 7.0, macOS 11.0, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, fixedSize: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, fixedSize: fixedSize)
  }

  static func custom(
    _ font: FontConvertible,
    size: CGFloat,
    relativeTo textStyle: SwiftUI.Font.TextStyle
  ) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size, relativeTo: textStyle)
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
