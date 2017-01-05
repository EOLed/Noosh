import Foundation
import UIKit
import reddift
import RxSwift

class LinkDetailCoordinator: Coordinator {
	let navigationController: UINavigationController
	private var linkDetailController: LinkDetailViewController?
	let listingsEndpoint: ListingsEndpoint

	init(navigationController: UINavigationController, session: Session) {
		self.navigationController = navigationController
		self.listingsEndpoint = ListingsEndpoint(session: session)
	}

	func start(link: LinkCellViewModel) {
		let article: Variable<ArticleViewModel> = Variable(ArticleViewModelImpl(link: link))
		let comments = Variable<[[CommentViewModel]]>([])
		let details =
			LinkDetailViewModelImpl(article: article, comments: CommentsViewModelImpl(threads: comments))

		_ = listingsEndpoint.getComments(linkId: link.id, sort: .hot)
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { (newArticle, newComments) in
				guard let newArticle = newArticle.children.first as? Link else { return }
				article.value = ArticleViewModelImpl(link: newArticle)
				comments.value = CommentConversionService().process(commentsListing: newComments)
			})

		let controller = LinkDetailViewController(link: details)

		linkDetailController = controller
		navigationController.pushViewController(controller, animated: true)
	}
}
