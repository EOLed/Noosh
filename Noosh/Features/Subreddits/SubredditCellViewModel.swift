import Foundation
import RxSwift

protocol SubredditCellViewModel {
	var name: Observable<String> { get }
	var logoURL: Observable<URL?> { get }
}

struct SubredditCellViewModelImpl: SubredditCellViewModel {
	let name: Observable<String>
	let logoURL: Observable<URL?>
}

extension SubredditCellViewModelImpl {
	init(name: String, logoURL: URL?) {
		self.name = Observable.of(name)
		self.logoURL = Observable.of(logoURL)
	}
}
