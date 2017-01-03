import Foundation
import reddift

protocol LinkDetailViewModel {
	var author: String { get }
	var authorFlair: String? { get }
	var body: String? { get }
	var commentCount: String { get }
	var createdAt: String { get }
	var subreddit: String { get }
	var title: String { get }
	var voteCount: String { get }
}

struct LinkDetailViewModelImpl: LinkDetailViewModel {
	let subreddit: String
	let title: String
	let body: String?
	let author: String
	let authorFlair: String?
	let createdAt: String
	let voteCount: String
	let commentCount: String
}

extension LinkDetailViewModelImpl {
	init(link: LinkCellViewModel) {
		self.author = link.username
		self.authorFlair = link.authorFlair
		self.body = link.body
		self.commentCount = link.commentCount
		self.createdAt = link.createdAt
		self.subreddit = link.subreddit
		self.title = link.title
		self.voteCount = link.voteCount
	}
}
