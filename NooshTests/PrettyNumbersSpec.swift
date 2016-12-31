import Foundation
import Quick
import Nimble

@testable import Noosh

class PrettyNumbersSpec: QuickSpec {
	override func spec() {
		describe("commentCount") {
			context("when there are < 10000 comments") {
				it("returns the actual number of comments") {
					let commentCount = 1000
					let subject = PrettyNumbers().commentCount(commentCount)

					expect(subject).to(equal("1000"))
				}
			}

			context("when there are between 10000 and 11000") {
				it("rounds to the nearest 1000, removing trailing 0") {
					let commentCount = 10022
					let subject = PrettyNumbers().commentCount(commentCount)

					expect(subject).to(equal("10K"))
				}
			}

			context("when there are between 11000 and 19999 comments") {
				it("rounds to the nearest 1000") {
					let commentCount = 19999
					let subject = PrettyNumbers().commentCount(commentCount)

					expect(subject).to(equal("19.9K"))
				}
			}
		}

		describe("vote count") {
			context("when there are < 10000 votes") {
				it("returns the actual number of votes") {
					let voteCount = 1000
					let subject = PrettyNumbers().voteCount(voteCount)

					expect(subject).to(equal("1000"))
				}
			}

			context("when there are between 10000 and 11000") {
				it("rounds to the nearest 1000, removing trailing 0") {
					let voteCount = 10022
					let subject = PrettyNumbers().voteCount(voteCount)

					expect(subject).to(equal("10K"))
				}
			}

			context("when there are between 11000 and 19999 votes") {
				it("rounds to the nearest 1000") {
					let voteCount = 19999
					let subject = PrettyNumbers().voteCount(voteCount)

					expect(subject).to(equal("19.9K"))
				}
			}
		}
	}
}
