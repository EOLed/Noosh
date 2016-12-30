import Foundation
import UIKit
import reddift
import RxSwift
import Rswift

class SubredditsCoordinator {
	fileprivate let navigationController: UINavigationController
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
			subreddits: SubredditsViewModelImpl(subreddits: subreddits),
			delegate: self
		)

		self.subredditsController = subredditsController

		navigationController.pushViewController(subredditsController, animated: true)
	}
}

extension SubredditsCoordinator: SubredditsViewControllerDelegate {
	func didSelectSubreddit(subreddit: SubredditCellViewModel) {
	}
}
