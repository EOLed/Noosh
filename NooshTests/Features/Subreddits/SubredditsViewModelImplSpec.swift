import Foundation
import Quick
import Nimble
import RxSwift
import reddift
import RxTest


@testable import Noosh

class SubredditsViewModelImplSpec: QuickSpec {
	override func spec() {
		var viewModel: SubredditsViewModelImpl!

		beforeEach {
			let scheduler = TestScheduler(initialClock: 0)
			let subreddits = scheduler.createHotObservable([
				next(100, [
					Subreddit(subreddit: "DIY"),
					Subreddit(subreddit: "Art"),
					Subreddit(subreddit: "food"),
					Subreddit(subreddit: "aww")
				]),
				completed(300)
			]).asObservable()

			viewModel = SubredditsViewModelImpl(subreddits: subreddits)

			_ = scheduler.start { subreddits }
		}

		it("sorts the subreddits alphabetically") {
			expect(viewModel.cells.value.map { $0.name }).to(equal(["Art", "aww", "DIY", "food"]))
		}
	}
}
