import Foundation
import reddift

protocol LinkCellViewModel {
	var username: String { get }
	var authorFlair: String? { get }
	var moderatorIconVisible: Bool { get }
	var adminIconVisible: Bool { get }
	var details: String? { get }
	var title: String { get }
	var commentCount: String { get }
	var voteCount: String { get }
	var previewImageURL: URL? { get }
	var previewImageVisible: Bool { get }
	var stickyIconVisible: Bool { get }
	var subreddit: String { get }
	var detailsVisible: Bool { get }
	var subredditVisible: Bool { get }
}

class LinkCellViewModelImpl: LinkCellViewModel {
	let username: String
	let authorFlair: String?
	let adminIconVisible: Bool = false
	let title: String
	let commentCount: String
	let voteCount: String
	let previewImageURL: URL?
	let moderatorIconVisible: Bool
	let previewImageVisible: Bool
	let stickyIconVisible: Bool
	let subreddit: String
	let subredditVisible: Bool

	private let createdAt: Int

	var details: String? {
		get { return buildDetails() }
	}

	var detailsVisible: Bool {
		get {
			if let details = self.details, details != "" {
				return true
			}

			return false
		}
	}

	init(
		subreddit: String,
		username: String,
		authorFlair: String? = nil,
		distinguished: Bool,
		title: String,
		previewImageURL: URL? = nil,
		createdAt: Int,
		commentCount: String,
		voteCount: String,
		stickyIconVisible: Bool,
		subredditVisible: Bool
	) {
		self.subreddit = subreddit
		self.username = username
		self.authorFlair = authorFlair
		self.moderatorIconVisible = distinguished
		self.title = title
		self.commentCount = commentCount
		self.voteCount = voteCount
		self.previewImageURL = previewImageURL
		self.createdAt = createdAt
		self.previewImageVisible = previewImageURL != nil
		self.stickyIconVisible = stickyIconVisible
		self.subredditVisible = subredditVisible
	}


	convenience init(link: Link, showSubreddit: Bool) {
		let previewImageURL: URL? = link.thumbnail == "self" || link.thumbnail == "default" ?
				nil : URL(string: link.thumbnail)

		let prettyNumbers = PrettyNumbers()

		self.init(
			subreddit: "r/\(link.subreddit)",
			username: link.author,
			authorFlair: link.authorFlairText,
			distinguished: link.distinguished,
			title: link.title,
			previewImageURL: previewImageURL,
			createdAt: link.createdUtc,
			commentCount: prettyNumbers.commentCount(link.numComments),
			voteCount: prettyNumbers.voteCount(link.ups - link.downs),
			stickyIconVisible: link.stickied,
			subredditVisible: showSubreddit
		)
	}

	private func buildDetails() -> String? {
		return authorFlair
	}
}
