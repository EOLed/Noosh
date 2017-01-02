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

		describe("timeAgo") {
			func buildTimeAgo(secondsAgo: Int) -> String {
				let currentDate = Date()
				let dateProvider = TestDateProvider(date: currentDate)

				let epochUtc = Int(currentDate.timeIntervalSince1970) - secondsAgo
				return PrettyNumbers(dateProvider: dateProvider).timeAgo(epochUtc: epochUtc)
			}

			context("when posted less than 1 minute ago") {
				it("returns time ago in nearest second") {
					expect(buildTimeAgo(secondsAgo: 59)).to(equal("59s"))
				}
			}

			context("when posted between 1 minute and 1 hour") {
				it("returns time ago in nearest minute") {
					expect(buildTimeAgo(secondsAgo: 186)).to(equal("3m"))
				}
			}

			context("when posted between 1 hour and 1 day") {
				it("returns time ago in nearest hour") {
					expect(buildTimeAgo(secondsAgo: 7211)).to(equal("2h"))
				}
			}

			context("when posted between 1 day and 1 week") {
				it("returns time ago in nearest day") {
					expect(buildTimeAgo(secondsAgo: 603936)).to(equal("6d"))
				}
			}

			context("when posted between 1 week and 31 days") {
				it("returns time ago in nearest week") {
					expect(buildTimeAgo(secondsAgo: 2677536)).to(equal("4w"))
				}
			}

			context("when posted between 31 days and 365 days") {
				it("returns time ago in nearest month") {
					expect(buildTimeAgo(secondsAgo: 31535136)).to(equal("11m"))
				}
			}

			context("when more than 365 days") {
				it("returns time ago in nearest year") {
					expect(buildTimeAgo(secondsAgo: 346580640)).to(equal("10y"))
				}
			}

			context("with negative time") {
				it("returns 0s") {
					expect(buildTimeAgo(secondsAgo: -10)).to(equal("0s"))
				}
			}
		}
	}
}
