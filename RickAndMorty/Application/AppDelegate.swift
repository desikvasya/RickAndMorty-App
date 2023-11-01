//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Виталий Коростелев on 01.11.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 100, vertical: 0), for: .default)
        
        return true
    }
}
