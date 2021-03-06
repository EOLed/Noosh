import Foundation
import SwiftRandom
import Rswift

@testable import Noosh

class LinkCellViewModelImplFactory {
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
}
