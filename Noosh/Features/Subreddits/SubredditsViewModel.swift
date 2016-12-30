import Foundation
import RxSwift
import reddift

protocol SubredditsViewModel {
	var cells: Variable<[SubredditCellViewModel]> { get }
}

class SubredditsViewModelImpl: SubredditsViewModel {
	private let subreddits: Observable<[Subreddit]>
	let cells: Variable<[SubredditCellViewModel]>

	init(subreddits: Observable<[Subreddit]>) {
		self.subreddits = subreddits
		cells = Variable([])

		_ = subreddits.subscribe(onNext: { [weak self] in
			guard let strongSelf = self else { return }
			strongSelf.cells.value = strongSelf.convertToViewModels(subreddits: $0)
		})
	}

	private func convertToViewModels(subreddits: [Subreddit]) -> [SubredditCellViewModel] {
		return subreddits.flatMap {
			SubredditCellViewModelImpl(name: $0.displayName, iconURL: URL(string: $0.iconImg))
		}
	}
}
