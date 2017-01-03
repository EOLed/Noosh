import Foundation
import Quick
import Nimble
import reddift
import RxBlocking
import OHHTTPStubs

@testable import Noosh

class ListingsEndpointSpec: QuickSpec {
	override func spec() {
		var endpoint: ListingsEndpoint!

		beforeEach {
			endpoint = ListingsEndpoint(session: Session())

			stub(condition: isMethodGET()) { req in
				let stubPath = OHPathForFile(
					"SubredditEndpointSpec_nba_subreddit_short.json",
					type(of: self)
				)

				return fixture(
					filePath: stubPath!,
					headers: ["Content-Type" as NSObject : "application/json" as AnyObject]
				)
			}
		}

		afterEach {
			OHHTTPStubs.removeAllStubs()
		}

		it("returns a page of the subreddit's listings") {
			let response = try!
				endpoint.getListing(
					paginator: Paginator(),
					subreddit: TestSubredditURLPath(path: "nba"),
					sort: .hot,
					timeFilterWithin: .all
				)
				.toBlocking()
				.toArray()

			expect(response.count).to(equal(1))
			expect(response.first!.children.map { $0.id })
				.to(equal(["5l46d9", "5l3v7e", "5l3vkf", "5l3z7i", "5l6vgl"]))
		}
	}
}

struct TestSubredditURLPath: SubredditURLPath {
	let path: String
}
