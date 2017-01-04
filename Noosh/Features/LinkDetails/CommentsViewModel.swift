import Foundation
import RxSwift

protocol CommentsViewModel {
	var comments: Variable<[CommentViewModel]> { get }
}

struct CommentsViewModelImpl: CommentsViewModel {
	let comments: Variable<[CommentViewModel]>
}
