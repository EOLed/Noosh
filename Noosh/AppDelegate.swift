//
//  AppDelegate.swift
//  Noosh
//
//  Created by Amos Chan on 2016-12-23.
//  Copyright © 2016 Amos Chan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var coordinator: AppCoordinator?

	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
	) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)

		guard let window = self.window else { return false }

		let navigationController = UINavigationController()
		window.rootViewController = navigationController
		window.makeKeyAndVisible()

		let coordinator = AppCoordinator(navigationController: navigationController)
		self.coordinator = coordinator

		coordinator.start()

		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
	}
}
