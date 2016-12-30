import Foundation
import UIKit
import Rswift
import RxSwift
import RxCocoa

class SubredditsViewController: UIViewController {
	private let subreddits: SubredditsViewModel
	private let disposeBag: DisposeBag

	@IBOutlet private weak var tableView: UITableView!

	required init?(coder aDecoder: NSCoder) {
		fatalError("Not supported")
	}

	init(title: String, subreddits: SubredditsViewModel) {
		self.subreddits = subreddits
		self.disposeBag = DisposeBag()

		super.init(nibName: R.nib.subredditsView.name, bundle: R.nib.subredditsView.bundle)

		self.title = title
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let cellIdentifier = R.reuseIdentifier.subredditsSubredditCell.identifier

		tableView.register(R.nib.subredditCellView(), forCellReuseIdentifier: cellIdentifier)

		subreddits.cells.asObservable()
			.bindTo(tableView.rx.items(cellIdentifier: cellIdentifier, cellType: SubredditCell.self)) { item in
				let (_, model, cell) = item
				cell.update(subreddit: model)
			}
			.addDisposableTo(disposeBag)
	}
}
