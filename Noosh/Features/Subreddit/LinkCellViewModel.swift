import Foundation
import reddift

protocol LinkCellViewModel {
	var username: String { get }
	var authorFlair: String? { get }
	var moderatorIconVisible: Bool { get }
	var adminIconVisible: Bool { get }
	var details: String { get }
	var title: String { get }
	var commentCount: String { get }
	var voteCount: String { get }
	var previewImageURL: NSURL? { get }
	var previewImageVisible: Bool { get }
	var stickyIconVisible: Bool { get }
}

class LinkCellViewModelImpl: LinkCellViewModel {
	let username: String
	let authorFlair: String?
	let adminIconVisible: Bool = false
	let title: String
	let commentCount: String
	let voteCount: String
	let previewImageURL: NSURL?
	let moderatorIconVisible: Bool
	let previewImageVisible: Bool
	let stickyIconVisible: Bool

	private let createdAt: Int

	var details: String {
		get { return buildDetails() }
	}

	init(
		username: String,
		authorFlair: String? = nil,
		distinguished: Bool,
		title: String,
		previewImageURL: NSURL? = nil,
		createdAt: Int,
		commentCount: String,
		voteCount: String,
		stickyIconVisible: Bool
	) {
		self.username = username
		self.authorFlair = authorFlair
		self.moderatorIconVisible = distinguished
		self.title = title
		self.commentCount = commentCount
		self.voteCount = voteCount
		self.previewImageURL = previewImageURL
		self.createdAt = createdAt
		self.previewImageVisible = false //previewImageURL != nil
		self.stickyIconVisible = stickyIconVisible
	}


	convenience init(link: Link) {
		let previewImageURLString = link.media?.oembed.thumbnailUrl
		let previewImageURL: NSURL? =
			previewImageURLString == nil ? nil : NSURL(string: previewImageURLString!)

		let prettyNumbers = PrettyNumbers()

		self.init(
			username: link.author,
			authorFlair: link.authorFlairText,
			distinguished: link.distinguished,
			title: link.title,
			previewImageURL: previewImageURL,
			createdAt: link.createdUtc,
			commentCount: prettyNumbers.commentCount(link.numComments),
			voteCount: prettyNumbers.voteCount(link.ups - link.downs),
			stickyIconVisible: link.stickied
		)
	}

	private func buildDetails() -> String {
		let details = "4h"
		if let authorFlair = self.authorFlair, authorFlair != "" {
			return "\(authorFlair) · \(details)"
		}

		return details
	}
}
