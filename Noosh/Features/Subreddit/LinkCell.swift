import Foundation
import UIKit

class LinkCell: UITableViewCell {
	
	@IBOutlet private weak var username: UILabel!
	@IBOutlet private weak var details: UILabel!
	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var commentCount: UILabel!
	@IBOutlet private weak var voteCount: UILabel!
	@IBOutlet private weak var previewImageWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var previewImageMarginWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var stickyIconWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var stickyIconMarginWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var subreddit: UILabel!
	@IBOutlet private weak var created: UILabel!
	@IBOutlet private weak var subredditMarginWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var detailsMarginWidthConstraint: CollapsibleConstraint!

	func update(link: LinkCellViewModel) {
		username.text = link.username
		details.text = link.details
		title.text = link.title
		commentCount.text = String(link.commentCount)
		voteCount.text = String(link.voteCount)
		previewImageWidthConstraint.toggle(show: link.previewImageVisible)
		previewImageMarginWidthConstraint.toggle(show: link.previewImageVisible)
		stickyIconWidthConstraint.toggle(show: link.stickyIconVisible)
		stickyIconMarginWidthConstraint.toggle(show: link.stickyIconVisible)

		detailsMarginWidthConstraint.toggle(show: link.detailsVisible)
		subreddit.text = link.subreddit
	}
}
