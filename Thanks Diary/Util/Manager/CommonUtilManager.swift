//
//  CommonUtilManager.swift
//  Thanks Diary
//
//  Created by 강조은 on 2023/08/08.
//

import UIKit

final class CommonUtilManager {
    
    private init() {}
    
    private static var _instance: CommonUtilManager?
    
    public static var instance: CommonUtilManager? {
        return _instance ?? CommonUtilManager()
    }
    
    var uuid: String {
        guard let uuid = UIDevice.current.identifierForVendor else { return "" }
        return uuid.uuidString
    }
    
    var appVersion: String {
        guard let version = Bundle.main.infoDictionary?[Constant.INFO_APP_VERSION] as? String else {
            return L10n.nonExistentAppinfo
        }
        return version
    }
    
    func dictionaryToObject <T: Decodable> (
        objectType: T.Type,
        dictionary: [[String: Any]]) -> [T]? {
        
        guard let dictionaries = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let objects = try? decoder.decode([T].self, from: dictionaries) else { return nil }
        return objects
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
}
