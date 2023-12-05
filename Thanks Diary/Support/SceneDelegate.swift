//
//  SceneDelegate.swift
//  Thanks Diary
//
//  Created by 강조은 on 2022/08/11.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController = vc
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        print(UserDefaultManager.instance.themeMode)
        if UserDefaultManager.instance.themeMode == ThemeMode.light.rawValue {
            window.overrideUserInterfaceStyle = .light
        } else {
            print("다크으")
            window.overrideUserInterfaceStyle = .dark
        }
    }
}
