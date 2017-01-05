import Foundation
import reddift

class CommentConversionService {
	let prettyNumbers: PrettyNumbers

	init(prettyNumbers: PrettyNumbers = PrettyNumbers(dateProvider: DateProviderImpl())) {
		self.prettyNumbers = prettyNumbers
	}

	func process(commentsListing: Listing) -> [[CommentViewModel]] {
		guard let comments = commentsListing.children.filter({ $0 is Comment }) as? [Comment] else {
			// FIXME do not crash in production
			fatalError("could not covert comment listings to [Comment]")
		}

		return comments.flatMap { toViewModels(comment: $0) }
	}

	func toViewModels(comment: Comment, replyLevels: [String : Int]? = nil) -> [CommentViewModel] {
		let replyLevels = replyLevels ?? buildReplyLevels(comment: comment)
		guard let replyLevel = replyLevels[comment.id] else {
			// FIXME do not crash in production
			fatalError("Could not determine reply level for comment \(comment.id)")
		}

		var comments = [toViewModel(comment: comment, replyLevel: replyLevel)]
		let replies = (comment.replies.children as? [Comment] ?? []).flatMap {
			toViewModels(comment: $0, replyLevels: replyLevels)
		}

		comments.append(contentsOf: replies)

		return comments
	}

	private typealias ReplyLevels = [String : Int]
	private func buildReplyLevels(cache: ReplyLevels = [:], comment: Comment, currentLevel: Int = 0)
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
