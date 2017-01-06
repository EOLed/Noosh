import Foundation
import RxSwift

protocol CommentsViewModel {
	var threads: Variable<[[CommentViewModel]]> { get }
}

struct CommentsViewModelImpl: CommentsViewModel {
	let threads: Variable<[[CommentViewModel]]>
}
