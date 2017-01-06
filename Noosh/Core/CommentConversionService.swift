import Foundation
import reddift

class CommentConversionService {
	private typealias ReplyLevels = [String : Int]

	func process(commentsListing: Listing) -> [[CommentViewModel]] {
		guard let comments = commentsListing.children.filter({ $0 is Comment }) as? [Comment] else {
			// FIXME do not crash in production
			fatalError("could not covert comment listings to [Comment]")
		}

		return comments.flatMap { buildViewModels(comment: $0) }
	}


	private func buildViewModels(comment: Comment, cache: ReplyLevels? = nil) -> [CommentViewModel] {
		let replyLevels = cache ?? buildReplyLevels(comment: comment)
		guard let replyLevel = replyLevels[comment.id] else {
			// FIXME do not crash in production
			fatalError("Could not determine reply level for comment \(comment.id)")
		}

		var comments: [CommentViewModel] =
			[CommentViewModelImpl(comment: comment, replyLevel: replyLevel)]

		let replies = (comment.replies.children as? [Comment] ?? []).flatMap {
			buildViewModels(comment: $0, cache: replyLevels)
		}

		comments.append(contentsOf: replies)

		return comments
	}

	private func buildReplyLevels(cache: ReplyLevels = [:], comment: Comment, currentLevel: Int = 0)
		-> ReplyLevels {
		var levels = cache
		levels[comment.id] = currentLevel

		let replies = comment.replies.children as? [Comment] ?? []
		return replies.reduce(levels) {
			buildReplyLevels(cache: $0, comment: $1, currentLevel: currentLevel + 1)
		}
	}
}
