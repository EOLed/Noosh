import Foundation
import UIKit
import Rswift
import AlamofireImage

class SubredditCell: UITableViewCell {
	@IBOutlet private weak var iconImageView: UIImageView!
	@IBOutlet private weak var subredditLabel: UILabel!

	func update(subreddit: SubredditCellViewModel) {
		subredditLabel.text = subreddit.name

		guard let placeholder = R.image.subredditPlaceholder() else { return }

		if let logoURL = subreddit.logoURL {
			let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
				size: iconImageView.frame.size,
				radius: iconImageView.frame.size.width / 2
			)
			iconImageView.af_setImage(withURL: logoURL, placeholderImage: placeholder, filter: filter)
		} else {
			iconImageView.image = placeholder
		}
	}
}
