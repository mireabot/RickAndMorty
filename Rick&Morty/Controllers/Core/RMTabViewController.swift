//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Mikhail Kolkov on 1/8/23.
//

import UIKit

final class RMTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupTabs()
    }
    
    private func setupTabs() {
        let charactersVS = UINavigationController(rootViewController: RMCharaterViewController())
        let locationVC = UINavigationController(rootViewController: RMLocationViewController())
        let episodesVC = UINavigationController(rootViewController: RMEpisodesViewController())
        let settingsVC = UINavigationController(rootViewController: RMSettingsViewController())
        
        charactersVS.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person"), tag: 0)
        locationVC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName: "globe"), tag: 1)
        episodesVC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName: "tv"), tag: 2)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        for nav in [charactersVS, locationVC, episodesVC, settingsVC] {
            nav.navigationBar.prefersLargeTitles = true
        }
        setViewControllers([
            charactersVS,
            locationVC,
            episodesVC,
            settingsVC
        ], animated: true)
    }
}
