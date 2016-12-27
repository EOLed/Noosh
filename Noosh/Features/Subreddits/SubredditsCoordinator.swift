import Foundation
import UIKit
import reddift
import RxSwift

class SubredditsCoordinator {
	private let navigationController: UINavigationController
	private let session: Session
	private var subredditsController: SubredditsViewController?

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
		self.session = session
	}

	func start() {
		let subreddits =
			SubredditEndpoint(session: session)
				.getSubreddits(subredditsWhere: .default)
				.flatMap { return Observable.of($0.map { s -> SubredditCellViewModel in
					SubredditCellViewModelImpl(name: s.displayName, logoURL: URL(string: s.iconImg))
				})}

		let subredditsController = SubredditsViewController(subreddits: subreddits)
		self.subredditsController = subredditsController

		navigationController.pushViewController(subredditsController, animated: true)
	}
}
