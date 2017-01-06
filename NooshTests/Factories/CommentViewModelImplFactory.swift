import Foundation
import SwiftRandom
import Rswift

@testable import Noosh

class CommentViewModelImplFactory {
	let defaultOptions: [CommentViewModelImplFactory.Fields : Any] = [
		.id: Randoms.randomInt(100000,200000),
		.author: Randoms.randomFakeName(),
		.body: Randoms.randomFakeConversation(),
		.createdAt: String(Int(Date().timeIntervalSince1970)),
		.edited: Randoms.randomBool(),
		.replyLevel: Randoms.randomInt(0,5),
		.score: Randoms.randomInt(0, 20000)
	]
}
