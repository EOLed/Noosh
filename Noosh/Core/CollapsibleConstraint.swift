import Foundation
import UIKit

class CollapsibleConstraint: NSLayoutConstraint {
	private var originalConstant: CGFloat = 0

	override func awakeFromNib() {
		super.awakeFromNib()

		originalConstant = constant
	}

	func collapse() {
		constant = 0
	}

	func expand() {
		constant = originalConstant
	}

	func toggle(show: Bool) {
		if show {
			return expand()
		}

		collapse()
	}
}
