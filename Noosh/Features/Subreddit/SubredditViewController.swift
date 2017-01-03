import Foundation
import UIKit
import RxSwift
import RxCocoa

class SubredditViewController: UIViewController {
	@IBOutlet private weak var listing: UITableView!
	private let links: Observable<[LinkCellViewModel]>
	private let disposeBag: DisposeBag
	private weak var delegate: SubredditViewControllerDelegate?

	required init?(coder aDecoder: NSCoder) {
		fatalError("Not supported")
	}

	init(
		title: String,
		links: Observable<[LinkCellViewModel]>,
		delegate: SubredditViewControllerDelegate
	) {
		self.links = links
		self.disposeBag = DisposeBag()
		self.delegate = delegate

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

		listing.rx.modelSelected(LinkCellViewModel.self)
			.subscribe(onNext: { [weak self] link in
				self?.delegate?.didSelectLink(link: link)
			})
			.addDisposableTo(disposeBag)

		listing.estimatedRowHeight = 200
		listing.rowHeight = UITableViewAutomaticDimension
	}
}

protocol SubredditViewControllerDelegate: class {
	func didSelectLink(link: LinkCellViewModel)
}
