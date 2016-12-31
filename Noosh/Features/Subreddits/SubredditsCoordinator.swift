import Foundation
import UIKit
import reddift
import RxSwift
import Rswift

class SubredditsCoordinator: Coordinator {
	fileprivate let navigationController: UINavigationController
	private let subredditsEndpoint: SubredditsEndpoint
	private var subredditsController: SubredditsViewController?
	fileprivate let session: Session

	fileprivate var subredditCoordinator: SubreddditCoordinator?

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
		self.subredditsEndpoint = SubredditsEndpoint(session: session)
		self.session = session
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
		let subredditCoordinator = SubreddditCoordinator(navigationController: navigationController,	session: session)

		self.subredditCoordinator = subredditCoordinator

		subredditCoordinator.start(subreddit: subreddit.name)
	}
}
