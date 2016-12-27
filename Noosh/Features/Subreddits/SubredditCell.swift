import Foundation
import UIKit

class SubredditCell: UITableViewCell {
	@IBOutlet private weak var iconImageView: UIImageView!
	@IBOutlet private weak var subredditLabel: UILabel!

	func update(subreddit: SubredditCellViewModel) {
		subredditLabel.text = subreddit.name
	}
}
