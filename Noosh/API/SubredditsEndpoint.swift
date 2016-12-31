import Foundation
import reddift
import RxSwift

class SubredditsEndpoint {
	private let session: Session

	init(session: Session) {
		self.session = session
	}

	func getSubreddits(subredditsWhere: SubredditsWhere, paginator: Paginator? = nil)
		-> Observable<[reddift.Subreddit]> {
		return Observable.create { [weak self] observer in
			guard let strongSelf = self else {
				observer.onCompleted()
				return Disposables.create()
			}

			strongSelf.observeThrowable(observer: observer) {
				try strongSelf.session.getSubreddit(subredditsWhere, paginator: paginator) {
					strongSelf.emitResultAndComplete(observer: observer, result: $0)
				}
			}

			return Disposables.create()
		}
	}

	private func observeThrowable<T>(observer: AnyObserver<[T]>, throwable: () throws -> Void) {
		do {
			try throwable()
		} catch {
			observer.onError(error)
		}
	}

	private func emitResultAndComplete<T>(observer: AnyObserver<[T]>, result: Result<Listing>) {
		guard let elements = result.value?.children.flatMap({ $0 as? T }) else { return }

		observer.onNext(elements)
		observer.onCompleted()
	}
}
