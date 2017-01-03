import Foundation
import SwiftRandom
import Rswift

@testable import Noosh

class LinkCellViewModelImplFactory {
	enum Fields {
		case authorFlair,
			body,
			commentCount,
			createdAt,
			defaultPreview,
			domain,
			moderatorIconVisible,
			previewImageURL,
			previewVisible,
			stickyIconVisible,
			subreddit,
			subredditVisible,
			title,
			username,
			voteCount;
	}

	let defaultOptions: [Fields : Any] = [
		.username: Randoms.randomFakeName(),
		.title: Randoms.randomFakeTitle(),
		.commentCount: String(Randoms.randomInt(0, 20000)),
		.voteCount: String(Randoms.randomInt(0, 20000)),
		.moderatorIconVisible: Randoms.randomBool(),
		.createdAt: String(Int(Randoms.randomDate().timeIntervalSince1970)),
		.stickyIconVisible: Randoms.randomBool(),
		.subredditVisible: Randoms.randomBool(),
		.subreddit: Randoms.randomFakeTag(),
		.defaultPreview: R.image.linkTypePost,
		.previewVisible: Randoms.randomBool()
	]

	func build(attributes: [Fields : Any]) -> LinkCellViewModelImpl {
		let allAttributes = attributes.merge(dict: defaultOptions)

		return LinkCellViewModelImpl(
			subreddit: allAttributes[.subreddit] as! String,
			subredditVisible: allAttributes[.subredditVisible] as! Bool,
			username: allAttributes[.username] as! String,
			authorFlair: toOptional(allAttributes[.authorFlair]),
			moderatorIconVisible: allAttributes[.moderatorIconVisible] as! Bool,
			stickyIconVisible: allAttributes[.stickyIconVisible] as! Bool,
			title: allAttributes[.title] as! String,
			domain: toOptional(allAttributes[.domain]),
			previewVisible: allAttributes[.previewVisible] as! Bool,
			previewImageURL: toOptional(allAttributes[.previewImageURL]),
			defaultPreview: allAttributes[.defaultPreview] as! ImageResource,
			body: toOptional(allAttributes[.body]),
			commentCount: allAttributes[.commentCount] as! String,
			voteCount: allAttributes[.voteCount] as! String,
			createdAt: allAttributes[.createdAt] as! String
		)
	}

	private func toOptional<T>(_ any: Any) -> T {
		return any as! T
	}
}
