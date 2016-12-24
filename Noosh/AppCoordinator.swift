import Foundation
import UIKit

class AppCoordinator {
	private let navigationController: UINavigationController
	private var childCoordinators: [AnyObject] = []

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		

		showSubreddits()
	}

	private func showSubreddits() {
		let subredditsCoordinator = SubredditsCoordinator(navigationController: navigationController)
		subredditsCoordinator.start()

		childCoordinators.append(subredditsCoordinator)
	}
}
