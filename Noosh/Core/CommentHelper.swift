import Foundation
import reddift

class CommentHelper {
	let prettyNumbers: PrettyNumbers

	init(prettyNumbers: PrettyNumbers = PrettyNumbers(dateProvider: DateProviderImpl())) {
		self.prettyNumbers = prettyNumbers
	}

	func toViewModels(comment: Comment, replyLevels: [String : Int]? = nil) -> [CommentViewModel] {
		let replyLevels = replyLevels ?? self.replyLevels(comment: comment, levels: [:])
		guard let replyLevel = replyLevels[comment.id] else { return [] }

		var comments = [toViewModel(comment: comment, replyLevel: replyLevel)]
		let replies =
			(comment.replies.children as? [Comment] ?? []).flatMap {
				toViewModels(comment: $0, replyLevels: replyLevels)
			}

		comments.append(contentsOf: replies)

		return comments
	}

	func replyLevels(comment: Comment, levels: [String : Int], currentLevel: Int = 0) -> [String : Int] {
		var levels = levels
		levels[comment.id] = currentLevel

		// FIXME remove !
		levels = (comment.replies.children as! [Comment]).reduce(levels) { levels, c in
			return replyLevels(comment: c, levels: levels, currentLevel: currentLevel + 1)
		}

		return levels
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
