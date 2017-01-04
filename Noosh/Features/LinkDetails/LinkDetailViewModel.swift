import Foundation
import RxSwift

protocol LinkDetailViewModel {
	var article: Variable<ArticleViewModel> { get }
	var comments: CommentsViewModel { get }
}

struct LinkDetailViewModelImpl: LinkDetailViewModel {
	let article: Variable<ArticleViewModel>
	let comments: CommentsViewModel
}
