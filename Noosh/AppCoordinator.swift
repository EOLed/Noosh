import Foundation
import UIKit
import reddift

class AppCoordinator: Coordinator {
	private let navigationController: UINavigationController
	private var childCoordinators: [Coordinator] = []

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
