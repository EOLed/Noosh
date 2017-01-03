import Foundation
import reddift
import Rswift

protocol LinkCellViewModel {
	var adminIconVisible: Bool { get }
	var authorFlair: String? { get }
	var body: String? { get }
	var commentCount: String { get }
	var createdAt: String { get }
	var defaultPreview: ImageResource { get }
	var details: String? { get }
	var detailsVisible: Bool { get }
	var domain: String? { get }
	var domainVisible: Bool { get }
	var moderatorIconVisible: Bool { get }
	var previewImageURL: URL? { get }
	var previewVisible: Bool { get }
	var stickyIconVisible: Bool { get }
	var subreddit: String { get }
	var subredditVisible: Bool { get }
	var title: String { get }
	var username: String { get }
	var voteCount: String { get }
}

struct LinkCellViewModelImpl: LinkCellViewModel, Factory {
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

	let adminIconVisible: Bool = false

	/// sourcery:begin: factoryFields
	let subreddit: String
	let subredditVisible: Bool
	let username: String
	let authorFlair: String?
	let moderatorIconVisible: Bool
	let stickyIconVisible: Bool
	let title: String
	let domain: String?
	let previewVisible: Bool
	let previewImageURL: URL?
	let defaultPreview: ImageResource
	let body: String?
	let commentCount: String
	let voteCount: String
	let createdAt: String
	/// sourcery:end

	private func buildDetails() -> String? {
		guard let domain = self.domain else { return nil }
		return domainVisible ? domain : nil
	}
}

extension LinkCellViewModelImpl {
	init(
		link: Link,
		showSubreddit: Bool,
		showMedia: Bool,
		prettyNumbers: PrettyNumbers = PrettyNumbers(dateProvider: DateProviderImpl())
	) {
		let previewImageURL: URL? = link.thumbnail == "self" || link.thumbnail == "default" ?
			nil : URL(string: link.thumbnail)

		let defaultPreview =
			link.thumbnail == "default" ? R.image.linkTypeExternal : R.image.linkTypePost


		self.init(
			subreddit: "r/\(link.subreddit)",
			subredditVisible: showSubreddit,
			username: link.author,
			authorFlair: link.authorFlairText,
			moderatorIconVisible: link.distinguished,
			stickyIconVisible: link.stickied,
			title: link.title,
			domain: link.domain,
			previewVisible: showMedia,
			previewImageURL: previewImageURL,
			defaultPreview: defaultPreview,
			body: link.selftext,
			commentCount: prettyNumbers.commentCount(link.numComments),
			voteCount: prettyNumbers.voteCount(link.ups - link.downs),
			createdAt: prettyNumbers.timeAgo(epochUtc: link.createdUtc)
		)
	}
}
