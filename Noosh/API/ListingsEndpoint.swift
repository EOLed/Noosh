import Foundation
import RxSwift
import reddift

class ListingsEndpoint {
	let session: Session

	init(session: Session) {
		self.session = session
	}

	func getListing(
		paginator: Paginator,
		subreddit: SubredditURLPath?,
		sort: LinkSortType,
		timeFilterWithin: TimeFilterWithin,
		limit: Int = 25
	) -> Observable<Listing> {
		return RxHelper().createObservable { [weak self] resultHandler in
			guard let strongSelf = self else { return }

			try strongSelf.session.getList(
				paginator,
				subreddit: subreddit,
				sort: sort,
				timeFilterWithin: timeFilterWithin,
				limit: limit,
				completion: resultHandler
			)
		}
	}

	func getComments(
		linkId: String,
		sort: CommentSort,
		commentIds: [String]? = nil,
		depth: Int? = nil,
		limit: Int? = nil
	) -> Observable<(Listing, Listing)> {
		return RxHelper().createObservable { [weak self] resultHandler in
			guard let strongSelf = self else { return }

			try strongSelf.session.getArticles(
				Link(id: linkId),
				sort: sort,
				comments: commentIds,
				depth: depth,
				limit: limit,
				completion: resultHandler
			)
		}
	}
}
