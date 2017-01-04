import Foundation
import UIKit
import reddift
import RxSwift

class LinkDetailCoordinator: Coordinator {
	let navigationController: UINavigationController
	private var linkDetailController: LinkDetailViewController?

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
	}

	func start(link: LinkCellViewModel) {
		let article: Variable<ArticleViewModel> = Variable(ArticleViewModelImpl(link: link))
		let controller = LinkDetailViewController(link: LinkDetailViewModelImpl(article: article))
		linkDetailController = controller
		navigationController.pushViewController(controller, animated: true)
	}
}
