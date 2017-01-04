import Foundation
import RxSwift

protocol LinkDetailViewModel {
	var article: Variable<ArticleViewModel> { get }
}

struct LinkDetailViewModelImpl: LinkDetailViewModel {
	let article: Variable<ArticleViewModel>
}
