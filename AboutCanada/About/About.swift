import Foundation

// MARK: - About

struct About: Decodable {
    let title: String
    let rows: [Row]
}

// MARK: - Row

struct Row: Decodable {
    let title, rowDescription, imageURL: String?

    enum CodingKeys: String, CodingKey {
        case title
        case rowDescription = "description"
        case imageURL = "imageHref"
    }

    var isNil: Bool {
        return title.isNil && rowDescription.isNil && imageURL.isNil
    }
}
