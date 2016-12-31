import Foundation
import UIKit

class LinkCell: UITableViewCell {
	
	@IBOutlet private weak var username: UILabel!
	@IBOutlet private weak var details: UILabel!
	@IBOutlet private weak var moderatorIconWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var adminIconWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var title: UILabel!
	@IBOutlet private weak var commentCount: UILabel!
	@IBOutlet private weak var voteCount: UILabel!
	@IBOutlet private weak var previewImageWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var moderatorIconMarginWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var adminIconMarginWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var previewImageMarginWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var stickyIconWidthConstraint: CollapsibleConstraint!
	@IBOutlet private weak var stickyIconMarginWidthConstraint: CollapsibleConstraint!

	func update(link: LinkCellViewModel) {
		username.text = link.username
		details.text = link.details
		moderatorIconWidthConstraint.toggle(show: link.moderatorIconVisible)
		moderatorIconMarginWidthConstraint.toggle(show: link.moderatorIconVisible)
		adminIconWidthConstraint.toggle(show: link.adminIconVisible)
		adminIconMarginWidthConstraint.toggle(show: link.adminIconVisible)
		title.text = link.title
		commentCount.text = String(link.commentCount)
		voteCount.text = String(link.voteCount)
		previewImageWidthConstraint.toggle(show: link.previewImageVisible)
		previewImageMarginWidthConstraint.toggle(show: link.previewImageVisible)
		stickyIconWidthConstraint.toggle(show: link.stickyIconVisible)
		stickyIconMarginWidthConstraint.toggle(show: link.stickyIconVisible)
	}
}
