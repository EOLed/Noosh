import Foundation
import UIKit
import reddift
import RxSwift

class SubredditCoordinator: Coordinator {
	fileprivate let navigationController: UINavigationController
	fileprivate let session: Session
	private let endpoint: ListingsEndpoint
	private var subredditController: SubredditViewController?
	fileprivate var linkDetailCoordinator: LinkDetailCoordinator?

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
		self.endpoint = ListingsEndpoint(session: session)
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

		let subredditController =
			SubredditViewController(title: subreddit, links: links, delegate: self)
		self.subredditController = subredditController

		navigationController.pushViewController(subredditController, animated: true)
	}

	deinit {
		print("deinit SubredditCoordinator")
	}
}

extension SubredditCoordinator: SubredditViewControllerDelegate {
	func didSelectLink(link: LinkCellViewModel) {
		let linkDetailCoordinator =
			LinkDetailCoordinator(navigationController: navigationController, session: session)

		self.linkDetailCoordinator = linkDetailCoordinator

		linkDetailCoordinator.start(link: link)
	}
}

private struct SubredditPath: SubredditURLPath {
	let path: String

	init(name: String) {
		self.path = "/r/\(name)"
	}
}
