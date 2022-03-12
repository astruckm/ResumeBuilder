//
//  SceneDelegate.swift
//  ResumeBuilder
//
//  Created by Andrew Struck-Marcell on 3/7/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let selectResumeVC = SelectResumeViewController(nibName: "SelectResumeViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: selectResumeVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }


}

