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

		subreddits
			.bindTo(tableView.rx.items(cellIdentifier: R.reuseIdentifier.subredditsSubredditCell.identifier, cellType: SubredditCell.self)) { (row, element, cell) in
				cell.
			}.addDisposableTo(disposeBag)
	}
}
