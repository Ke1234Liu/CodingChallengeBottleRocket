//
//  AppCoordinator.swift
//  ProjectBottleRocket
//
//  Created by Ke on 10/12/21.
//

import UIKit

class AppCoordinator: NSObject {
    private let tabController: UITabBarController
    private let restaurantStack: UINavigationController
    private let webNavController: UINavigationController
    private let mainVM: RestaurantsViewModel
    
    init(tabController: UITabBarController = UITabBarController(),
         restaurantNavC: UINavigationController = UINavigationController(),
         webNavC: UINavigationController = UINavigationController(),
         mainVM: RestaurantsViewModel = RestaurantsViewModel()) {
        self.tabController = tabController
        self.restaurantStack = restaurantNavC
        self.webNavController = webNavC
        self.mainVM = mainVM
    }
    
    func start() {
        self.restaurantStack.delegate = self
        self.restaurantStack.pushViewController(RestaurantsMainViewController(viewModel: self.mainVM), animated: false)
        self.restaurantStack.tabBarItem = UITabBarItem(title: "lunch", image: UIImage.tabLunch, selectedImage: UIImage.tabLunch?.withTintColor(UIColor.white))
        self.webNavController.pushViewController(WebViewController(), animated: false)
        self.webNavController.tabBarItem = UITabBarItem(title: "internets", image: UIImage.tabInternet, selectedImage: UIImage.tabInternet?.withTintColor(UIColor.white))

        self.tabController.viewControllers = [self.restaurantStack, self.webNavController]

        self.setUpTabBarUI()
    }
    
    private func setUpTabBarUI() {
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.avenirRegular(for: 10) as Any, NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.avenirRegular(for: 10) as Any, NSAttributedString.Key.foregroundColor: UIColor.tabBarItemNotSelected], for: .normal)
        UITabBar.appearance().barTintColor = UIColor.tabBarColor
        UITabBar.appearance().tintColor = UIColor.white
    }
    
    @objc
    private func presentMapViewController(){
        let vc = MapViewController(mainVM: self.mainVM)
        self.restaurantStack.present(vc, animated: true)
    }
    
    @objc
    private func navigateBack(){
        self.restaurantStack.popViewController(animated: true)
    }
}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.navigationBar.barTintColor = UIColor.navBarGreen
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.avenirBold(for: 17) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        viewController.navigationItem.title = "Lunch Tyme"
        let rightNavButton = UIBarButtonItem(image: UIImage.mapIcon, style: .plain, target: self, action: #selector(self.presentMapViewController))
        rightNavButton.tintColor = .white
        viewController.navigationItem.setRightBarButton(rightNavButton, animated: false)
        if let detailVC = viewController as? RestaurantInfoViewController {
            let leftBarButton = UIBarButtonItem(image: UIImage.backIcon, style: .plain, target: self, action: #selector(self.navigateBack))
            leftBarButton.tintColor = .white
            detailVC.navigationItem.setLeftBarButton(leftBarButton, animated: false)
        }
        
    }
}
