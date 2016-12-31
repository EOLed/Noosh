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

	func update(link: LinkCellViewModel) {
		username.text = link.username
		details.text = link.details
		moderatorIconWidthConstraint.toggle(show: link.moderatorIconVisible)
		adminIconWidthConstraint.toggle(show: link.adminIconVisible)
		title.text = link.title
		commentCount.text = String(link.commentCount)
		voteCount.text = String(link.voteCount)
	}
}
