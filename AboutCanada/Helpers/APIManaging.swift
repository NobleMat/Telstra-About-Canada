import Foundation

enum APIError: Error {
    case urlError
    case cannotProcessData
}

protocol APIManaging {

    /// Request to the URL using the given path, method and headers
    /// - Parameters:
    ///   - path: The path to be appended to the base URL
    ///   - method: The HTTP method to be used
    ///   - headers: The HTTP header to be used
    /// - Returns: A DataResult that contains a Data object or an error
    func request(
        path: String,
        isImage: Bool,
        method: HTTPMethod,
        headers: HTTPHeaders,
        timeout: Double
    ) -> DataResult
}

extension APIManaging {

    func request(
        path: String,
        isImage: Bool = false,
        method: HTTPMethod = HTTPMethod.get,
        headers: HTTPHeaders = [],
        timeout: Double = 20
    ) -> DataResult {
        return request(path: path, isImage: isImage, method: method, headers: headers, timeout: timeout)
    }
}
