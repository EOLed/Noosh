import Foundation
import RxSwift

protocol SubredditCellViewModel {
	var name: String { get }
	var iconURL: URL? { get }
}

struct SubredditCellViewModelImpl: SubredditCellViewModel {
	let name: String
	let iconURL: URL?
}
