protocol AboutManaging {
    func fetchData(completion: @escaping Action<DecodableResult<About>>)
}

final class AboutManager: AboutManaging {

    func fetchData(completion: @escaping Action<DecodableResult<About>>) {
        let pathURL: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

        API.request(path: pathURL).responseDecodable(completion: completion)
    }
}
