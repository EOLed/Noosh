import Foundation
import Quick
import Nimble
import reddift
import RxBlocking
import OHHTTPStubs

@testable import Noosh

class SubredditEndpointSpec: QuickSpec {
	override func spec() {
		var endpoint: SubredditEndpoint!

		beforeEach {
			endpoint = SubredditEndpoint(session: Session())

			stub(condition: isMethodGET()) { req in
				let stubPath = OHPathForFile(
					"SubredditsEndpointSpec_default_subreddits_short.json",
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

		it("returns a list of subreddits") {
			let response = try! endpoint.getSubreddits(subredditsWhere: .default)
				.toBlocking()
				.toArray()

			expect(response.count).to(equal(1))


			let subredditNames = response.first.map { subreddits -> [String] in
				return subreddits.map { $0.displayName }
			}

			expect(subredditNames!).to(equal(["gadgets", "sports", "gaming"]))
		}
	}
}
