import Foundation
import UIKit
import RxSwift
import RxCocoa

class SubredditViewController: UIViewController {
	@IBOutlet private weak var listing: UITableView!
	private let links: Observable<[LinkCellViewModel]>
	private let disposeBag: DisposeBag

	required init?(coder aDecoder: NSCoder) {
		fatalError("Not supported")
	}

	init(title: String, links: Observable<[LinkCellViewModel]>) {
		self.links = links
		self.disposeBag = DisposeBag()


		super.init(nibName: R.nib.subredditView.name, bundle: R.nib.subredditView.bundle)

		self.title = title
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		let cellIdentifier = R.reuseIdentifier.linkCellView.identifier

		listing.register(R.nib.linkCellView(), forCellReuseIdentifier: cellIdentifier)

		links
			.bindTo(listing.rx.items(cellIdentifier: cellIdentifier, cellType: LinkCell.self)) {
				let (_, model, cell) = $0
				cell.update(link: model)
			}
			.addDisposableTo(disposeBag)

		listing.estimatedRowHeight = 200
		listing.rowHeight = UITableViewAutomaticDimension
	}
}
