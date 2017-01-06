import Foundation
import Quick
import Nimble
import reddift

@testable import Noosh

class CommentConversionServiceSpec: QuickSpec {
	override func spec() {
		describe("process") {
			context("happy path") {
				var commentThread: [[CommentViewModel]]!

				beforeEach {
					let comment1 = self.commentFromJson(withResource: "nested_comments_1")
					let comment2 = self.commentFromJson(withResource: "nested_comments_2")
					let comments = Listing(children: [comment1, comment2], paginator: Paginator())
					commentThread = CommentConversionService().process(commentsListing: comments)
				}

				it("returns a flat list of comment view models") {
					expect(commentThread[0].map { $0.id })
						.to(equal(["dc0ppb3", "dc0ppjg", "dc0pq4h", "dc0prtq", "dc0ps0p"]))
					expect(commentThread[1].map { $0.id }).to(equal(["dc0ps86", "dc0wcrt"]))
				}

				it("maintains the reply level of each comment") {
					expect(commentThread[0].map { $0.replyLevel }).to(equal([0, 1, 2, 1, 2]))
					expect(commentThread[1].map { $0.replyLevel }).to(equal([0, 1]))
				}
			}
		}
	}

	func commentFromJson(withResource resource: String) -> Comment {
		guard let path =
			Bundle(for: type(of: self)).path(forResource: resource, ofType: "json") else {
				fatalError("Could not read \(resource).json")
		}

		let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
		let json = try! JSONSerialization.jsonObject(
			with: data,
			options: JSONSerialization.ReadingOptions.mutableContainers
			) as! JSONDictionary

		return Comment(json: json)
	}
}
