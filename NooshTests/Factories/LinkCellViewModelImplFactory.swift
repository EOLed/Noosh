import Foundation
import SwiftRandom

@testable import Noosh

class LinkCellViewModelImplFactory {
	enum Fields {
		case username,
			authorFlair,
			title,
			commentCount,
			voteCount,
			previewImageURL,
			moderatorIconVisible,
			previewImageVisible,
			stickyIconVisible,
			subreddit,
			subredditVisible,
			createdAt,
			domain;
	}

	let defaultOptions: [Fields : Any] = [
		.username: Randoms.randomFakeName(),
		.title: Randoms.randomFakeTitle(),
		.commentCount: String(Randoms.randomInt(0, 20000)),
		.voteCount: String(Randoms.randomInt(0, 20000)),
		.moderatorIconVisible: Randoms.randomBool(),
		.createdAt: Int(Randoms.randomDate().timeIntervalSince1970),
		.stickyIconVisible: Randoms.randomBool(),
		.subredditVisible: Randoms.randomBool(),
		.subreddit: Randoms.randomFakeTag()
	]

	func build(attributes: [Fields : Any]) -> LinkCellViewModelImpl {
		let allAttributes = attributes.merge(dict: defaultOptions)
		return LinkCellViewModelImpl(
			subreddit: allAttributes[.subreddit] as! String,
			username: allAttributes[.username] as! String,
			authorFlair: toOptional(allAttributes[.authorFlair]),
			moderatorIconVisible: allAttributes[.moderatorIconVisible] as! Bool,
			title: allAttributes[.title] as! String,
			previewImageURL: toOptional(allAttributes[.previewImageURL]),
			domain: allAttributes[.domain] as! String,
			createdAt: allAttributes[.createdAt] as! Int,
			commentCount: allAttributes[.commentCount] as! String,
			voteCount: allAttributes[.voteCount] as! String,
			stickyIconVisible: allAttributes[.stickyIconVisible] as! Bool,
			subredditVisible: allAttributes[.subredditVisible] as! Bool
		)
	}

	private func toOptional<T>(_ any: Any) -> T {
		return any as! T
	}
}