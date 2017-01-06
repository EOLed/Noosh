import Foundation
import UIKit

class LinkDetailViewController: UIViewController {
	private let link: LinkDetailViewModel

	@IBOutlet private weak var authorFlair: UILabel!
	@IBOutlet private weak var body: UILabel!
	@IBOutlet private weak var commentCount: UILabel!
	@IBOutlet private weak var createdAt: UILabel!
	@IBOutlet private weak var linkTitle: UILabel!
	@IBOutlet private weak var subreddit: UILabel!
	@IBOutlet private weak var username: UILabel!
	@IBOutlet private weak var voteCount: UILabel!

	init(link: LinkDetailViewModel) {
		self.link = link
		super.init(nibName: R.nib.linkDetailView.name, bundle: R.nib.linkDetailView.bundle)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		_ = link.article.asObservable().subscribe(onNext: { [weak self] in self?.update(article: $0) })
	}

	private func update(article: ArticleViewModel) {
		createdAt.text = article.createdAt
		subreddit.text = article.subreddit
		username.text = article.author

		if let authorFlair = article.authorFlair {
			self.authorFlair.text = authorFlair
		} else {
			authorFlair.text = "hi"
		}

		linkTitle.text = article.title

		if let body = article.body {
			self.body.text = body
		} else {
			self.body.text = "bod"
		}

		voteCount.text = article.voteCount
		commentCount.text = article.commentCount
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("not supported")
	}
}
