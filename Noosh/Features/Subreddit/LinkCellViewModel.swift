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
	var domain: String? { get }
	var domainVisible: Bool { get }
	var createdAt: String { get }
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
	let domain: String?
	let createdAt: String

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

	var domainVisible: Bool {
		guard let domain = self.domain else { return false }

		if domain.hasPrefix("self.") || domain == "reddit.com" {
			return false
		}

		return true
	}

	init(
		subreddit: String,
		username: String,
		authorFlair: String?,
		moderatorIconVisible: Bool,
		title: String,
		previewImageURL: URL?,
		domain: String?,
		createdAt: String,
		commentCount: String,
		voteCount: String,
		stickyIconVisible: Bool,
		subredditVisible: Bool
	) {
		self.subreddit = subreddit
		self.username = username
		self.authorFlair = authorFlair
		self.moderatorIconVisible = moderatorIconVisible
		self.title = title
		self.commentCount = commentCount
		self.voteCount = voteCount
		self.previewImageURL = previewImageURL
		self.createdAt = createdAt
		self.previewImageVisible = previewImageURL != nil
		self.stickyIconVisible = stickyIconVisible
		self.subredditVisible = subredditVisible
		self.domain = domain
	}

	convenience init(
		link: Link,
		showSubreddit: Bool,
		prettyNumbers: PrettyNumbers = PrettyNumbers(dateProvider: DateProviderImpl())
	) {
		let previewImageURL: URL? = link.thumbnail == "self" || link.thumbnail == "default" ?
				nil : URL(string: link.thumbnail)

		self.init(
			subreddit: "r/\(link.subreddit)",
			username: link.author,
			authorFlair: link.authorFlairText,
			moderatorIconVisible: link.distinguished,
			title: link.title,
			previewImageURL: previewImageURL,
			domain: link.domain,
			createdAt: prettyNumbers.timeAgo(epochUtc: link.createdUtc),
			commentCount: prettyNumbers.commentCount(link.numComments),
			voteCount: prettyNumbers.voteCount(link.ups - link.downs),
			stickyIconVisible: link.stickied,
			subredditVisible: showSubreddit
		)
	}

	private func buildDetails() -> String? {
		guard let domain = self.domain else { return nil }
		return domainVisible ? domain : nil
	}
}
