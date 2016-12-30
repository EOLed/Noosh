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
		let subreddits =
			subredditsEndpoint
				.getSubreddits(subredditsWhere: .default)
				.observeOn(MainScheduler.instance)
				.flatMap {
					return Observable.of($0.map { s -> SubredditCellViewModel in
						SubredditCellViewModelImpl(name: s.displayName, iconURL: URL(string: s.iconImg))
					})
				}

		let subredditsController = SubredditsViewController(
			title: R.string.localizable.subredditsTitle(),
			subreddits: subreddits
		)

		self.subredditsController = subredditsController

		navigationController.pushViewController(subredditsController, animated: true)
	}
}
