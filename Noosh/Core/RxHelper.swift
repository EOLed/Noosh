import Foundation
import reddift
import RxSwift

class RxHelper {
	func createObservable<T>(request: @escaping (@escaping (Result<T>) -> Void) throws -> Void) -> Observable<T> {
		return Observable.create { observer in
			do {
				try request { result in
					guard let value = result.value else { return }
					observer.onNext(value)
					observer.onCompleted()
				}
			} catch {
				observer.onError(error)
			}

			return Disposables.create()
		}
	}
}
