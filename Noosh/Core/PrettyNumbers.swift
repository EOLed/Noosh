import Foundation

class PrettyNumbers {
	func commentCount(_ count: Int) -> String {
		if count > 10000 {
			return String(format: "%gK", roundTo(places: 1, value: Double(count) / 1000.0))
		}

		return "\(count)"
	}

	func voteCount(_ count: Int) -> String {
		return commentCount(count)
	}

	private func roundTo(places:Int, value: Double) -> Double {
		let divisor = pow(10.0, Double(places))
		return floor(value * divisor) / divisor
	}
}
