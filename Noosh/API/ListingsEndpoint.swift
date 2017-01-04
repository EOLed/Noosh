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
		return Observable.create { [weak self] observer in
			guard let strongSelf = self else {
				observer.onCompleted()
				return Disposables.create()
			}

			strongSelf.observeThrowable(observer: observer) {
				try strongSelf.session.getList(
					paginator,
					subreddit: subreddit,
					sort: sort,
					timeFilterWithin: timeFilterWithin,
					limit: limit
				) { result in
					guard let value = result.value else { return }
					observer.onNext(value)
					observer.onCompleted()
				}
			}

			return Disposables.create()
		}
	}

	func getComments(
		linkId: String,
		sort: CommentSort,
		commentIds: [String]? = nil,
		depth: Int? = nil,
		limit: Int? = nil
	) -> Observable<(Listing, Listing)> {
		return Observable.create { [weak self] observer in
			guard let strongSelf = self else {
				observer.onCompleted()
				return Disposables.create()
			}

			let link = Link(id: linkId)

			strongSelf.observeThrowable(observer: observer) {
				try strongSelf.session.getArticles(
					link,
					sort: sort,
					comments: commentIds,
					depth: depth,
					limit: limit
				) { result in
					guard let value = result.value else { return }
					observer.onNext(value)
					observer.onCompleted()
				}
			}

			return Disposables.create()
		}
	}

	private func observeThrowable<T>(observer: AnyObserver<T>, throwable: () throws -> Void) {
		do {
			try throwable()
		} catch {
			observer.onError(error)
		}
	}
}
