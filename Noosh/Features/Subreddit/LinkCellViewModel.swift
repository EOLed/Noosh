import Foundation
import reddift

protocol LinkCellViewModel {
	var username: String { get }
	var authorFlair: String? { get }
	var moderatorIconVisible: Bool { get }
	var adminIconVisible: Bool { get }
	var details: String { get }
	var title: String { get }
	var commentCount: Int { get }
	var voteCount: Int { get }
	var previewImageURL: NSURL? { get }
	var previewImageVisible: Bool { get }
}

class LinkCellViewModelImpl: LinkCellViewModel {
	let username: String
	let authorFlair: String?
	let adminIconVisible: Bool = false
	let title: String
	let commentCount: Int
	let voteCount: Int
	let previewImageURL: NSURL?
	let moderatorIconVisible: Bool
	let previewImageVisible: Bool

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
		commentCount: Int,
		voteCount: Int
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
	}


	convenience init(link: Link) {
		let previewImageURLString = link.media?.oembed.thumbnailUrl
		let previewImageURL: NSURL? =
			previewImageURLString == nil ? nil : NSURL(string: previewImageURLString!)

		self.init(
			username: link.author,
			authorFlair: link.authorFlairText,
			distinguished: link.distinguished,
			title: link.title,
			previewImageURL: previewImageURL,
			createdAt: link.createdUtc,
			commentCount: link.numComments,
			voteCount: link.ups - link.downs
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
