import Foundation
import reddift

class CommentHelper {
	let prettyNumbers: PrettyNumbers

	init(prettyNumbers: PrettyNumbers = PrettyNumbers(dateProvider: DateProviderImpl())) {
		self.prettyNumbers = prettyNumbers
	}

	func toViewModels(comment: Comment, replyLevels: ReplyLevels? = nil) -> [CommentViewModel] {
		let replyLevels = replyLevels ?? buildReplyLevels(comment: comment)
		guard let replyLevel = replyLevels[comment.id] else { return [] }

		var comments = [toViewModel(comment: comment, replyLevel: replyLevel)]
		let replies = (comment.replies.children as? [Comment] ?? []).flatMap {
			toViewModels(comment: $0, replyLevels: replyLevels)
		}

		comments.append(contentsOf: replies)

		return comments
	}

	typealias ReplyLevels = [String : Int]
	func buildReplyLevels(cache: ReplyLevels = [:], comment: Comment, currentLevel: Int = 0)
		-> ReplyLevels {
		var levels = cache
		levels[comment.id] = currentLevel

		let replies = comment.replies.children as? [Comment] ?? []
		return replies.reduce(levels) {
			buildReplyLevels(cache: $0, comment: $1, currentLevel: currentLevel + 1)
		}
	}

	private func toViewModel(comment: Comment, replyLevel: Int) -> CommentViewModel {
		return CommentViewModelImpl(
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
