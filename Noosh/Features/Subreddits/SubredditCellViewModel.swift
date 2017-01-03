import Foundation
import RxSwift

protocol SubredditCellViewModel {
	var name: String { get }
	var iconURL: URL? { get }
	var showMedia: Bool { get }
}

struct SubredditCellViewModelImpl: SubredditCellViewModel {
	let name: String
	let iconURL: URL?
	let showMedia: Bool
}
