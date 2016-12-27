import Foundation
import UIKit
import reddift

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
		let subredditsCoordinator = SubredditsCoordinator(
			navigationController: navigationController,
			session: Session()
		)

		subredditsCoordinator.start()

		childCoordinators.append(subredditsCoordinator)
	}
}
