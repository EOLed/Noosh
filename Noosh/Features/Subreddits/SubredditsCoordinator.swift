import Foundation
import UIKit
import reddift
import RxSwift
import Rswift

class SubredditsCoordinator {
	private let navigationController: UINavigationController
	private let subredditsEndpoint: SubredditEndpoint
	private var subredditsController: SubredditsViewController?

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
		self.subredditsEndpoint = SubredditEndpoint(session: session)
	}

	func start() {
		let subreddits = subredditsEndpoint.getSubreddits(subredditsWhere: .default)
			.observeOn(MainScheduler.instance)

		let subredditsController = SubredditsViewController(
			title: R.string.localizable.subredditsTitle(),
			subreddits: SubredditsViewModelImpl(subreddits: subreddits)
		)

		self.subredditsController = subredditsController

		navigationController.pushViewController(subredditsController, animated: true)
	}
}
