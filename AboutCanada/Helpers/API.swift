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
        isImage: Bool = false,
        method: HTTPMethod = HTTPMethod.get,
        headers: HTTPHeaders = [],
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
        urlRequest: URLRequest,
        isImage: Bool = false
    ) -> DataResult {
        var result: DataResult = .failure(APIError.cannotProcessData)

        let semaphore = DispatchSemaphore(value: 0)

        URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else { return }

            if !isImage {
                result = .success(data)
            } else if let mimeType = response?.mimeType,
                mimeType.hasPrefix("image") {
                result = .success(data)
            }
            semaphore.signal()
        }.resume()

        semaphore.wait()

        return result
    }
}
