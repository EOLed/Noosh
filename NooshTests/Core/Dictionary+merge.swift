import Foundation

extension Dictionary {
	func merge(dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
		return reduce(dict) { (acc, current) in var acc = acc
			let (key, value) = current
			acc[key] = value
			return acc
		}
	}
}
