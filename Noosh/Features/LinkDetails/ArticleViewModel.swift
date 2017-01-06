import Foundation
import reddift

protocol ArticleViewModel {
	var author: String { get }
	var authorFlair: String? { get }
	var body: String? { get }
	var commentCount: String { get }
	var createdAt: String { get }
	var subreddit: String { get }
	var title: String { get }
	var voteCount: String { get }
}

struct ArticleViewModelImpl: ArticleViewModel {
	let subreddit: String
	let title: String
	let body: String?
	let author: String
	let authorFlair: String?
	let createdAt: String
	let voteCount: String
	let commentCount: String
}

extension ArticleViewModelImpl {
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

extension ArticleViewModelImpl {
	init(link: Link, prettyNumbers: PrettyNumbers = PrettyNumbers(dateProvider: DateProviderImpl())) {
		self.author = link.author
		self.authorFlair = link.authorFlairText
		self.body = link.selftext
		self.commentCount = prettyNumbers.commentCount(link.numComments)
		self.createdAt = prettyNumbers.timeAgo(epochUtc: link.createdUtc)
		self.subreddit = "r/\(link.subreddit)"
		self.title = link.title
		self.voteCount = prettyNumbers.voteCount(link.ups - link.downs)
	}
}
