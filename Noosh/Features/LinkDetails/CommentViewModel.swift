import Foundation
import reddift

protocol CommentViewModel {
	var id: String { get }
	var author: String { get }
	var authorFlair: String? { get }
	var body: String { get }
	var createdAt: String { get }
	var edited: Bool { get }
	var parentId: String? { get }
	var replyLevel: Int { get }
	var score: Int? { get }
}

struct CommentViewModelImpl: CommentViewModel, Factory {
	/// sourcery:begin: factoryFields
	let id: String
	let author: String
	let authorFlair: String?
	let body: String
	let createdAt: String
	let edited: Bool
	let parentId: String?
	let replyLevel: Int
	let score: Int?
	/// sourcery:end
}

extension CommentViewModelImpl {
	init(
		comment: Comment,
		replyLevel: Int,
		prettyNumbers: PrettyNumbers = PrettyNumbers(dateProvider: DateProviderImpl())
	) {
		self.init(
			id: comment.id,
			author: comment.author,
			authorFlair: comment.authorFlairText,
			body: comment.body,
			createdAt: prettyNumbers.timeAgo(epochUtc: comment.createdUtc),
			edited: comment.edited,
			parentId: comment.parentId,
			replyLevel: replyLevel,
			score: comment.score
		)
	}
}
