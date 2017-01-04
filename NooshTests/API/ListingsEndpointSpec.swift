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

		describe("getListing") {
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

		describe("getComments") {
			beforeEach {
				endpoint = ListingsEndpoint(session: Session())

				stub(condition: isMethodGET()) { req in
					let stubPath = OHPathForFile(
						"ListingsEndpointSpec_comments_short.json",
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

			it("returns a tuple of the link listing and a listing of comments") {
				let response =
					try! endpoint.getComments(linkId: "123", sort: .hot).toBlocking().toArray()

				expect(response.count).to(equal(1))

				let (link, commentsListing) = response.first!

				expect(link.children.map { $0.id }).to(equal(["5lt5o4"]))

				let comments = commentsListing.children as! [Comment]
				expect(comments.map { $0.id }).to(equal(["dbybdpc"]))
				expect(comments.first!.replies.children.map { $0.id })
					.to(equal(["dbydpa1", "dbygejz", "dbydian", "dbyoby8"]))
			}
		}
	}
}

struct TestSubredditURLPath: SubredditURLPath {
	let path: String
}
