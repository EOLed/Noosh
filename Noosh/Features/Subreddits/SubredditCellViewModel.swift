import Foundation
import RxSwift

protocol SubredditCellViewModel {
	var name: String { get }
	var logoURL: URL? { get }
}

struct SubredditCellViewModelImpl: SubredditCellViewModel {
	let name: String
	let logoURL: URL?
}
