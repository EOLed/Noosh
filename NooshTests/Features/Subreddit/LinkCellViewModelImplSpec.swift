import Foundation
import Quick
import Nimble
import reddift

@testable import Noosh

class LinkCellViewModelImplSpec: QuickSpec {
	override func spec() {
		describe("domainVisible()") {
			context("when the domain is reddit.com") {
				it("returns false") {
					let cell = LinkCellViewModelImplFactory().build(attributes: [
						.domain : "reddit.com"
					])

					let subject = cell.domainVisible

					expect(subject).to(beFalse())
				}
			}

			context("when the domain is self.*") {
				it("returns false") {
					let cell = LinkCellViewModelImplFactory().build(attributes: [
						.domain : "self.AskReddit"
					])

					let subject = cell.domainVisible
					
					expect(subject).to(beFalse())
				}
			}

			context("when it has a valid domain") {
				it("returns true") {
					let cell = LinkCellViewModelImplFactory().build(attributes: [
						.domain : "nba.com"
					])

					let subject = cell.domainVisible

					expect(subject).to(beTrue())
				}
			}
		}

		describe("init(Link)") {
			var subject: LinkCellViewModelImpl!

			context("with a normal link") {
				beforeEach {
					let link = Link(json: [
						"subreddit" : "AskReddit" as AnyObject,
						"ups" : 16000 as AnyObject,
						"downs" : 500 as AnyObject,
						"num_comments" : 99999 as AnyObject
					])

					subject = LinkCellViewModelImpl(link: link, showSubreddit: false)
				}

				it("returns a pretty count of total votes") {
					expect(subject.voteCount).to(equal("15.5K"))
				}

				it("returns a pretty count of comments") {
					expect(subject.commentCount).to(equal("99.9K"))
				}

				it("adds r/ prefix to subreddit") {
					expect(subject.subreddit).to(equal("r/AskReddit"))
				}
			}

			context("with a default thumbnail") {
				beforeEach {
					let link = Link(json: [
						"thumbnail" : "default" as AnyObject
					])

					subject = LinkCellViewModelImpl(link: link, showSubreddit: false)
				}

				it("does not create a preview URL") {
					expect(subject.previewImageURL).to(beNil())
				}
			}

			context("with a self thumbnail") {
				beforeEach {
					let link = Link(json: [
						"thumbnail" : "self" as AnyObject
					])

					subject = LinkCellViewModelImpl(link: link, showSubreddit: false)
				}

				it("does not create a preview URL") {
					expect(subject.previewImageURL).to(beNil())
				}
			}

			context("with a thumbnail") {
				beforeEach {
					let link = Link(json: [
						"thumbnail" : "http://example.com" as AnyObject
					])

					subject = LinkCellViewModelImpl(link: link, showSubreddit: false)
				}

				it("does not create a preview URL") {
					expect(subject.previewImageURL!.absoluteString).to(equal("http://example.com"))
				}
			}
		}
	}
}
