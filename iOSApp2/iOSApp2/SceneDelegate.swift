//
//  SceneDelegate.swift
//  iOSApp2
//
//  Created by Sumana Dhital on 2024-06-08.
//

import UIKit

// Scene delegate class to manage the app's UI lifecycle
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // Main window of the app
    var window: UIWindow?
    
    // Data model for managing order lists
    let dataModel = DataModel()

    // Method called when the scene is being created and connected to the session
    func scene(
      _ scene: UIScene,
      willConnectTo session: UISceneSession,
      options connectionOptions: UIScene.ConnectionOptions
    ) {
      // Get the root navigation controller
      let navigationController = window!.rootViewController as! UINavigationController
      // Get the initial view controller and set its data model
      let controller = navigationController.viewControllers[0] as! AllListsViewController
      controller.dataModel = dataModel
    }

    // Method called when the scene is disconnected
    func sceneDidDisconnect(_ scene: UIScene) {
        // Save data when the scene is disconnected
        saveData()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    // Method called when the scene enters background
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save data when the scene enters the background
        saveData()
    }

    // MARK: - Helper Methods
    // Method to save the order lists data
    func saveData() {
      dataModel.saveOrderlists()
    }



}

