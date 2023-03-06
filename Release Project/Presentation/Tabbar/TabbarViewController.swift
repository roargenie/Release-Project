//
//  TabbarViewController.swift
//  Release Project
//
//  Created by 이명진 on 2022/10/21.
//

import UIKit


final class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        delegate = self
        UITabBar.appearance().backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.barTintColor = .white
        
        let mainVC = UINavigationController(rootViewController: HomeViewController(mainView: HomeView(), viewModel: HomeViewModel()))
        mainVC.navigationBar.tintColor = .black
        let addItemVC = UINavigationController(rootViewController: AddItemViewController())
        addItemVC.navigationBar.tintColor = .black
        let diaryVC = UINavigationController(rootViewController: DiaryViewController())
        diaryVC.navigationBar.tintColor = .black
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        settingVC.navigationBar.tintColor = .black
        
        self.setViewControllers([mainVC, addItemVC, diaryVC, settingVC], animated: true)
        
        if let items = self.tabBar.items {
            items[0].selectedImage = UIImage(systemName: "house.fill")
            items[0].image = UIImage(systemName: "house")
            items[0].title = "홈"
            
            items[1].selectedImage = UIImage(systemName: "archivebox.fill")
            items[1].image = UIImage(systemName: "archivebox")
            items[1].title = "내 서랍장"
            
            items[2].selectedImage = UIImage(systemName: "calendar.circle.fill")
            items[2].image = UIImage(systemName: "calendar.circle")
            items[2].title = "다이어리"
            
            items[3].selectedImage = UIImage(systemName: "gearshape.fill")
            items[3].image = UIImage(systemName: "gearshape")
            items[3].title = "설정"
        }
    }
}
