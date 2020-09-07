import Foundation

let API = APIManager.default

class APIManager {

    // MARK: - Properties

    // MARK: Public

    static let `default` = APIManager()
}

// MARK: - Conformance

// MARK: APIManaging

extension APIManager: APIManaging {

    func request(
        path: String,
        method: HTTPMethod = HTTPMethod.get,
        headers: HTTPHeaders = [HTTPHeader.acceptedTypes],
        timeout: Double = 20
    ) -> DataResult {
        guard
            let url = URL(string: path)
        else {
            return .failure(APIError.urlError)
        }
        var urlRequest: URLRequest = URLRequest.request(using: url, timeoutInterval: timeout)
        urlRequest.httpMethod = method.value
        headers.forEach { header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
        }

        return request(urlRequest: urlRequest)
    }
}

// MARK: - Private Helpers

// MARK: URLRequest

private extension URLRequest {

    static func request(using url: URL, timeoutInterval: Double) -> URLRequest {
        return URLRequest(
            url: url,
            timeoutInterval: timeoutInterval
        )
    }
}

// MARK: Fetch data

private extension APIManager {

    func request(
        urlRequest: URLRequest
    ) -> DataResult {
        var response: DataResult = .failure(APIError.cannotProcessData)

        let semaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: urlRequest) { data, _, _ in
            if let data = data {
                response = .success(data)
            }
            semaphore.signal()
        }.resume()

        semaphore.wait()

        return response
    }
}
