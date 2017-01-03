import Foundation
import UIKit
import reddift

class LinkDetailCoordinator: Coordinator {
	let navigationController: UINavigationController
	private var linkDetailController: LinkDetailViewController?

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
	}

	func start(link: LinkCellViewModel) {
		let controller = LinkDetailViewController(link: LinkDetailViewModelImpl(link: link))
		linkDetailController = controller
		navigationController.pushViewController(controller, animated: true)
	}
}
