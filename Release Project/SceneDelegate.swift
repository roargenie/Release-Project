//
//  SceneDelegate.swift
//  Release Project
//
//  Created by 이명진 on 2022/09/10.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let mainVC = HomeViewController()
        let nav1 = UINavigationController(rootViewController: mainVC)
        nav1.navigationBar.tintColor = .black
        let addItemVC = AddItemViewController()
        let nav2 = UINavigationController(rootViewController: addItemVC)
        nav2.navigationBar.tintColor = .black
        let diaryVC = DiaryViewController()
        let nav3 = UINavigationController(rootViewController: diaryVC)
        nav3.navigationBar.tintColor = .black
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([nav1, nav2, nav3], animated: true)
        tabBarController.tabBar.tintColor = .black
        
        if let items = tabBarController.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "house.fill")
            items[0].image = UIImage(systemName: "house")
            items[0].title = "홈"
            
            items[1].selectedImage = UIImage(systemName: "archivebox.fill")
            items[1].image = UIImage(systemName: "archivebox")
            items[1].title = "내 서랍장"
            
            items[2].selectedImage = UIImage(systemName: "calendar.circle.fill")
            items[2].image = UIImage(systemName: "calendar.circle")
            items[2].title = "다이어리"
            
        }
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        UIApplication.shared.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

