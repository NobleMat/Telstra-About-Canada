import Foundation

struct HTTPHeader: Hashable {

    /// Name of the header.
    let name: String

    /// Value of the header.
    let value: String

    /// Creates an instance from the given `name` and `value`.
    ///
    /// - Parameters:
    ///   - name:  The name of the header.
    ///   - value: The value of the header.
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    var description: String {
        return "\(name): \(value)"
    }
}

extension HTTPHeader {
    static var acceptedTypes: HTTPHeader {
        return HTTPHeader(name: "Accept", value: "application/json")
    }
}

typealias HTTPHeaders = [HTTPHeader]
