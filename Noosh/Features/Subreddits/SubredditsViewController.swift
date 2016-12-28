import Foundation
import UIKit
import Rswift
import RxSwift
import RxCocoa

class SubredditsViewController: UIViewController {
	private let subreddits: Observable<[SubredditCellViewModel]>
	private let disposeBag: DisposeBag

	@IBOutlet private weak var tableView: UITableView!

	required init?(coder aDecoder: NSCoder) {
		fatalError("Not supported")
	}

	init(subreddits: Observable<[SubredditCellViewModel]>) {
		self.subreddits = subreddits
		self.disposeBag = DisposeBag()
		super.init(nibName: R.nib.subredditsView.name, bundle: R.nib.subredditsView.bundle)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let cellIdentifier = R.reuseIdentifier.subredditsSubredditCell.identifier

		tableView.register(R.nib.subredditCellView(), forCellReuseIdentifier: cellIdentifier)

		subreddits
			.bindTo(tableView.rx.items(cellIdentifier: cellIdentifier, cellType: SubredditCell.self)) { (row, element, cell) in
				cell.update(subreddit: element)
			}
			.addDisposableTo(disposeBag)
	}
}
