import Foundation
import UIKit
import Rswift
import RxSwift
import RxCocoa

class SubredditsViewController: UIViewController {
	private let subreddits: SubredditsViewModel
	private let disposeBag: DisposeBag
	private weak var delegate: SubredditsViewControllerDelegate?

	@IBOutlet private weak var tableView: UITableView!

	required init?(coder aDecoder: NSCoder) {
		fatalError("Not supported")
	}

	init(
		title: String,
		subreddits: SubredditsViewModel,
		delegate: SubredditsViewControllerDelegate
	) {
		self.subreddits = subreddits
		self.disposeBag = DisposeBag()
		self.delegate = delegate

		super.init(nibName: R.nib.subredditsView.name, bundle: R.nib.subredditsView.bundle)

		self.title = title
		navigationItem.backBarButtonItem =
			UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let cellIdentifier = R.reuseIdentifier.subredditsSubredditCell.identifier

		tableView.register(R.nib.subredditCellView(), forCellReuseIdentifier: cellIdentifier)

		subreddits.cells.asObservable()
			.bindTo(tableView.rx.items(cellIdentifier: cellIdentifier, cellType: SubredditCell.self)) {
				let (_, model, cell) = $0
				cell.update(subreddit: model)
			}
			.addDisposableTo(disposeBag)

		tableView.rx.modelSelected(SubredditCellViewModel.self)
			.subscribe(onNext: { [weak self] subreddit in
				self?.delegate?.didSelectSubreddit(subreddit: subreddit)
			})
			.addDisposableTo(disposeBag)
	}
}

protocol SubredditsViewControllerDelegate: class {
	func didSelectSubreddit(subreddit: SubredditCellViewModel)
}
