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
        method: HTTPMethod = .get,
        timeout: Double = 20
    ) -> DataResult {
        guard
            let url = URL(string: path)
        else {
            return .failure(APIError.urlError)
        }
        var urlRequest: URLRequest = URLRequest(
            url: url,
            timeoutInterval: timeout
        )
        urlRequest.httpMethod = method.value

        return request(urlRequest: urlRequest, isImage: isImage)
    }
}

// MARK: - Private Helpers

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
