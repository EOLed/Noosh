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
		createdAt.text = link.createdAt
		subreddit.text = link.subreddit
		username.text = link.author

		if let authorFlair = link.authorFlair {
			self.authorFlair.text = authorFlair
		} else {
			authorFlair.text = "hi"
		}

		linkTitle.text = link.title

		if let body = link.body {
			self.body.text = body
		} else {
			self.body.text = "bod"
		}

		voteCount.text = link.voteCount
		commentCount.text = link.commentCount
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("not supported")
	}
}
