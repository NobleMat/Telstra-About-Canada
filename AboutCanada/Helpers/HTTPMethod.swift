import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"

    var value: String { return rawValue }
}
