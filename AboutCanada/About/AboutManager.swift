protocol AboutManaging {
    func fetchData(completion: @escaping Action<Result<About, Error>>)
}

final class AboutManager: AboutManaging {

    func fetchData(completion: @escaping Action<Result<About, Error>>) {
        let pathURL: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

        API.request(path: pathURL).responseDecodable(completion: completion)
    }
}
