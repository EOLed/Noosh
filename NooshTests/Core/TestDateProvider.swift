import Foundation

@testable import Noosh

class TestDateProvider: DateProvider {
	let date: Date

	init(date: Date) {
		self.date = date
	}

	func get() -> Date {
		return date
	}
}
