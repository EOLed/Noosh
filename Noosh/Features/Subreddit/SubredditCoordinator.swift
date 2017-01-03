import Foundation
import UIKit
import reddift
import RxSwift

class SubreddditCoordinator: Coordinator {
	private let navigationController: UINavigationController
	private let session: Session
	private let endpoint: SubredditEndpoint
	private var subredditController: SubredditViewController?

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
		self.endpoint = SubredditEndpoint(session: session)
		self.session = session
	}

	func start(subreddit: String, showMedia: Bool) {
		let links: Observable<[LinkCellViewModel]> = endpoint
			.getListing(
				paginator: Paginator(),
				subreddit: SubredditPath(name: subreddit),
				sort: .hot,
				timeFilterWithin: .all
			)
			.observeOn(MainScheduler.instance)
			.flatMap { Observable.of($0.children.flatMap { $0 as? Link }) }
			.flatMap { Observable.of($0.map { LinkCellViewModelImpl(link: $0, showSubreddit: false, showMedia: showMedia) }) }

		let subredditController = SubredditViewController(title: subreddit, links: links)
		self.subredditController = subredditController

		navigationController.pushViewController(subredditController, animated: true)
	}

	deinit {
		print("deinit SubredditCoordinator")
	}
}

private struct SubredditPath: SubredditURLPath {
	let path: String

	init(name: String) {
		self.path = "/r/\(name)"
	}
}
