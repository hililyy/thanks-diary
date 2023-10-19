//
//  ResourceManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/10/18.
//

import UIKit

final class ResourceManager {
    
    private init() {}
    
    private static var _instance: ResourceManager?
    
    static var instance: ResourceManager? {
        if _instance == nil {
            _instance = ResourceManager()
        }
        return _instance
    }
    
    func getMainColor() -> UIColor {
        guard let color = UserDefaultManager.instance?.int(UserDefaultKey.THEME_COLOR.rawValue) else { return Asset.Color.lightGrayBlue.color }
        switch color {
        case 0:
            return Asset.Color.lightGrayBlue.color
        case 1:
            return Asset.Color.pink.color
        case 2:
            return Asset.Color.yellow.color
        case 3:
            return Asset.Color.green.color
        case 4:
            return Asset.Color.purple.color
        default:
            return Asset.Color.lightGrayBlue.color
        }
    }
    
    func getMainDeepColor() -> UIColor {
        guard let color = UserDefaultManager.instance?.int(UserDefaultKey.THEME_COLOR.rawValue) else { return Asset.Color.lightGrayBlue.color }
        switch color {
        case 0:
            return Asset.Color.grayBlue.color
        case 1:
            return Asset.Color.deepPink.color
        case 2:
            return Asset.Color.deepYellow.color
        case 3:
            return Asset.Color.deepGreen.color
        case 4:
            return Asset.Color.deepPurple.color
        default:
            return Asset.Color.grayBlue.color
        }
    }
    
    func getDetailWriteImage() -> UIImage {
        guard let color = UserDefaultManager.instance?.int(UserDefaultKey.THEME_COLOR.rawValue) else { return Asset.Image.icDetailWrite.image }
        switch color {
        case 0:
            return Asset.Image.icDetailWrite.image
        case 1:
            return Asset.Image.icDetailWritePink.image
        case 2:
            return Asset.Image.icDetailWriteYellow.image
        case 3:
            return Asset.Image.icDetailWriteGreen.image
        case 4:
            return Asset.Image.icDetailWritePurple.image
        default:
            return Asset.Image.icDetailWrite.image
        }
    }
    
    func getSimpleWriteImage() -> UIImage {
        guard let color = UserDefaultManager.instance?.int(UserDefaultKey.THEME_COLOR.rawValue) else { return Asset.Image.icDetailWrite.image }
        switch color {
        case 0:
            return Asset.Image.icSimpleWrite.image
        case 1:
            return Asset.Image.icSimpleWritePink.image
        case 2:
            return Asset.Image.icSimpleWriteYellow.image
        case 3:
            return Asset.Image.icSimpleWriteGreen.image
        case 4:
            return Asset.Image.icSimpleWritePurple.image
        default:
            return Asset.Image.icSimpleWrite.image
        }
    }
    
    func getUnderLineImage() -> UIImage {
        guard let color = UserDefaultManager.instance?.int(UserDefaultKey.THEME_COLOR.rawValue) else { return Asset.Image.icDetailWrite.image }
        switch color {
        case 0:
            return Asset.Image.imgUnderlineBlue.image
        case 1:
            return Asset.Image.imgUnderlinePink.image
        case 2:
            return Asset.Image.imgUnderlineYellow.image
        case 3:
            return Asset.Image.imgUnderlineGreen.image
        case 4:
            return Asset.Image.imgUnderlineBlue.image
        default:
            return Asset.Image.icSimpleWrite.image
        }
    }
    
    func getFont(type: FontType, size: CGFloat) -> UIFont {
        var fontSize = size
        
        switch type {
        case .nanumBarunGothic:
            return FontFamily.NanumBarunGothic.ultraLight.font(size: fontSize)
        case .nanumBarunPen:
            return FontFamily.NanumBarunpenOTF.regular.font(size: fontSize)
        case .harunanum:
            fontSize += 3
            return FontFamily.OwnglyphHaruNanum.regular.font(size: fontSize)
        case .hagom:
            fontSize += 3
            return FontFamily.OwnglyphAlcomhagom.regular.font(size: fontSize)
        case .wiri:
            fontSize += 3
            return FontFamily.OwnglyphWiri.regular.font(size: fontSize)
        case .boksung:
            fontSize += 3
            return FontFamily.OwnglyphBoksoong.regular.font(size: fontSize)
        case .yeonyu:
            fontSize += 3
            return FontFamily.OwnglyphYeonu.regular.font(size: fontSize)
        case .pretendard:
            return FontFamily.Pretendard.regular.font(size: fontSize)
        case .kotrahope:
            return FontFamily.KotraHope.regular.font(size: fontSize)
        }
    }
    
    func getFont(size: CGFloat) -> UIFont {
        var fontSize = size
        
        guard let savedFont = UserDefaultManager.instance?.int(UserDefaultKey.THEME_FONT.rawValue) else { return FontFamily.NanumBarunGothic.ultraLight.font(size: size) }
        let fontType = FontType(rawValue: savedFont)
        
        switch fontType {
        case .nanumBarunGothic:
            return FontFamily.NanumBarunGothic.ultraLight.font(size: fontSize)
        case .nanumBarunPen:
            return FontFamily.NanumBarunpenOTF.regular.font(size: fontSize)
        case .harunanum:
            fontSize += 3
            return FontFamily.OwnglyphHaruNanum.regular.font(size: fontSize)
        case .hagom:
            fontSize += 3
            return FontFamily.OwnglyphAlcomhagom.regular.font(size: fontSize)
        case .wiri:
            fontSize += 3
            return FontFamily.OwnglyphWiri.regular.font(size: fontSize)
        case .boksung:
            fontSize += 3
            return FontFamily.OwnglyphBoksoong.regular.font(size: fontSize)
        case .yeonyu:
            fontSize += 3
            return FontFamily.OwnglyphYeonu.regular.font(size: fontSize)
        case .pretendard:
            return FontFamily.Pretendard.regular.font(size: fontSize)
        case .kotrahope:
            return FontFamily.KotraHope.regular.font(size: fontSize)
        default:
            return FontFamily.NanumBarunGothic.ultraLight.font(size: fontSize)
        }
    }
}
