import Foundation
import UIKit
import AlamofireImage
import Rswift

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
	@IBOutlet private weak var previewImage: UIImageView!

	func update(link: LinkCellViewModel) {
		username.text = link.username
		details.text = link.details
		title.text = link.title
		commentCount.text = String(link.commentCount)
		voteCount.text = String(link.voteCount)
		stickyIconWidthConstraint.toggle(show: link.stickyIconVisible)
		stickyIconMarginWidthConstraint.toggle(show: link.stickyIconVisible)

		detailsMarginWidthConstraint.toggle(show: link.detailsVisible)

		created.text = link.createdAt

		if link.subredditVisible {
			subreddit.text = link.subreddit
		} else {
			subreddit.text = ""
			subredditMarginWidthConstraint.collapse()
		}

		updatePreviewImage(link: link)

		previewImage.layer.cornerRadius = 5
	}

	private func updatePreviewImage(link: LinkCellViewModel) {
		previewImageWidthConstraint.toggle(show: link.previewVisible)
		previewImageMarginWidthConstraint.toggle(show: link.previewVisible)

		guard link.previewVisible else { return }

		if let previewImageURL = link.previewImageURL {
			previewImage.af_setImage(withURL: previewImageURL)
		} else {
			previewImage.image = UIImage(
				named: link.defaultPreview.name,
				in: link.defaultPreview.bundle,
				compatibleWith: nil
			)
		}
	}
}
