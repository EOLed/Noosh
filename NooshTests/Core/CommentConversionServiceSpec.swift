import Foundation
import Quick
import Nimble
import reddift

@testable import Noosh

class CommentConversionServiceSpec: QuickSpec {
	override func spec() {
		describe("toViewModels") {
			context("happy path") {
				var commentThread: [CommentViewModel]!

				beforeEach {
					guard let path =
						Bundle(for: type(of: self)).path(forResource: "nested_comments", ofType: "json") else {
							return assertionFailure("Could not read nested_comments.json")
						}

					let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
					let json = try! JSONSerialization.jsonObject(
						with: data,
						options: JSONSerialization.ReadingOptions.mutableContainers
					) as! JSONDictionary

					let helper = CommentConversionService()
					let comment = Comment(json: json)
					commentThread = helper.toViewModels(comment: comment)
				}

				it("returns a flat list of comment view models") {
					expect(commentThread.map { $0.id })
						.to(equal(["dc0ppb3", "dc0ppjg", "dc0pq4h", "dc0prtq", "dc0ps0p"]))
				}

				it("maintains the reply level of each comment") {
					expect(commentThread.map { $0.replyLevel }).to(equal([0, 1, 2, 1, 2]))
				}
			}
		}
	}
}
